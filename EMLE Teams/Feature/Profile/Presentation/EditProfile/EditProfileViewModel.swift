//
//  EditProfileViewModel.swift
//  EMLE Learners
//
//  Created by Abdelrhman Sultan on 10/05/2024.
//

import Foundation
import EMLECore
import CountryPicker
import UIKit
import Combine

typealias StudyingFieldDelegate = GenericAction<StudyingField>
typealias GraduationYearDelegate = GenericAction<GraduationYear>
typealias EducationStatusDelegate = GenericAction<EducationStatus>
typealias LocationDelegate = GenericAction<Location>

class EditProfileViewModel: MainViewModel {
    
    @Published var profileData: ProfileData = .placeholder
    
    @Published var country = Country(isoCode: "EG")
    
    @Published var selectedCountry = ""
    
    @Published var isPresentingCountryCodePicker = false
    
    @Published var phoneNumberChecker: ViewChecker = ViewChecker(state: .empty,
                                                                 messages: [.wrong : RegistrationStrings.incorrectPhoneText.localized])
    
    @Published var parentField: StudyingField?
    
    @Published var fields: [StudyingField] = []
    
    @Published var displayedFields: [StudyingField] = []
    
    @Published var selectedField: StudyingField = .placeholder
    
    @Published var isPresentFieldsView = false
    
    @Published var graduationYearSelected: GraduationYear = .placeholder
    
    @Published var graduationYears: [GraduationYear] = []
    
    @Published var isPresentGraduationYears = false
    
    @Published var educationStatusSelected: EducationStatus = .placeholder
    
    @Published var educationStatuses: [EducationStatus] = []
    
    @Published var isPresentEducationStatuses = false
    
    @Published var locationSelected: Location = .placeholder
    
    @Published var locations: [Location] = []
    
    @Published var overView: String = ""
    
    @Published var isPresentLocation = false
    
    @Published var isProfileImageChanged = false
    
    @Published var profileImage: ImagePickerImage = .empty {
        didSet {
            isPresentingImagePicker = false
            isProfileImageChanged = true
        }
    }
    
    @Published var isPresentingSourceImagePicker = false
    
    @Published var isPresentingImagePicker = false
    
    @Published var fieldsLoadingState: LoadingState = .loaded
    
    @Published var profileDataLoadingState: LoadingState = .loaded
    
    @Published var editProfileLoadingState: LoadingState = .loaded
    
    var sourceType: ImagePickerSourceType = .photos
    
    var isDoneButtonDisabled: Bool = false
    
    var isSaveChangesDisable: Bool {
        profileData.name.isEmpty ||
        !phoneNumberChecker.isCorrect ||
        educationStatusSelected.educationStatusId == -1 ||
        locationSelected.locationId == -1 ||
        graduationYearSelected.displayName == ""
    }
    
    var fullPhoneNumber: String {
        if profileData.mobile.first == "0" {
            var phone = profileData.mobile
            phone.removeFirst()
            return "+" + country.phoneCode + phone
        } else {
            return "+" + country.phoneCode + profileData.mobile
        }
    }
    
    var coordinator: EditProfileCoordinating
    
    var cancellables = Set<AnyCancellable>()
    
    @Inject var getUserUseCase: GetUserUseCase<User>
    
    @Inject var getGlobalIndexUseCase: GetGlobalIndexUseCase
    
    @Inject var getProfileDataUseCase: GetProfileDataUseCase
    
    @Inject var editProfileUseCase: EditProfileUseCase
    
    init(coordinator: EditProfileCoordinating) {
        self.coordinator = coordinator
    }
}

extension EditProfileViewModel {
    
    func onAppear() {
        configureCountryCode()
        
        setGraduationYears()
        
        displayedFields = fields
        
        getGlobals()
        
        hideTabBar()
        self.overView = profileData.overview ?? ""
        
    }
    
    func onChangePhotoClick() {
        isPresentingSourceImagePicker = true
    }
    
    func onCountryCodeClick() {
        isPresentingCountryCodePicker = true
    }
    
    func setCountryCode(country: Country) {
        
        self.country = country
        
        isPresentingCountryCodePicker = false
        
        validatePhone("")
        
        setCountryCode()
        
    }
    
    func validatePhone(_: String) {
        if profileData.mobile.isEmpty {
            phoneNumberChecker.state = .empty
        } else {
            phoneNumberChecker.state = fullPhoneNumber.isValidPhone() ? .correct : .wrong
            print(fullPhoneNumber)
        }
    }
    
    func onSaveChangesClick() {
        let editProfile = EditProfile(name: profileData.name,
                                      email: profileData.email,
                                      overview: overView,
                                      locationId: locationSelected.locationId,
                                      fieldId: selectedField.fieldId,
                                      typeId: educationStatusSelected.educationStatusId,
                                      graduationYear: graduationYearSelected.displayName,
                                      image: isProfileImageChanged ? profileImage.imageData : nil)
        
        editProfileData(editProfile: editProfile)
    }
    
    func onUploadPhotoClick() {
        sourceType = .photos
        isPresentingSourceImagePicker = false
        isPresentingImagePicker = true
    }
    
    func onTakePhotoClick() {
        sourceType = .camera
        isPresentingSourceImagePicker = false
        isPresentingImagePicker = true
    }
    
    func selectField(field: StudyingField) {
        if !field.children.isEmpty {
            displayedFields = field.children
            parentField = field
        } else {
            isPresentFieldsView = false
        }
        selectedField = field
    }
    
    func onBackClick() {
        if let parentId = parentField?.parentId {
            parentField = getStudyingField(id: parentId, in: fields)
        } else {
            parentField = nil
        }
        displayedFields = parentField?.children ?? fields
    }
    
    func onGraduationYearsClick() {
        isPresentGraduationYears = true
    }
    
    func selectYear(year: GraduationYear) {
        isPresentGraduationYears = false
        graduationYearSelected = year
    }
    
    func onEducationStatusesClick() {
        isPresentEducationStatuses = true
    }
    
    func selectEducationStatus(educationStatus: EducationStatus) {
        isPresentEducationStatuses = false
        educationStatusSelected = educationStatus
    }
    
    func onLocationsClick() {
        isPresentLocation = true
    }
    
    func selectLocation(location: Location) {
        isPresentLocation = false
        locationSelected = location
    }
}

extension EditProfileViewModel {
    
    private func configureCountryCode() {
        if let country = CountryManager.shared.getCountries().first(where: { $0.phoneCode == profileData.mobileCodeWithoutPlus }) {
            
            self.country = country
            setCountryCode()
        }
    }
    
    private func setCountryCode() {
        
        selectedCountry = RegistrationStrings.phoneCodeSS.localizedFormat(arguments: country.isoCode.getFlag(), "+\(country.phoneCode)")
    }
    
    private func getStudyingField(id: Int, in fields: [StudyingField]) -> StudyingField? {
        if let index = fields.firstIndex(where: { $0.fieldId == id }) {
            return fields[index]
        }
        
        var studyingFields: StudyingField? = nil
        
        for i in 0..<fields.count {
            studyingFields = getStudyingField(id: id, in: fields[i].children)
        }
        
        return studyingFields
    }
    
    private func setGraduationYears() {
        for year in 2000...2030 {
            graduationYears.append(GraduationYear(displayName: "\(year)", id: year - 2000 + 1))
        }
    }
}

extension EditProfileViewModel: UseCaseViewModel {
    
    private func getGlobals() {
        do {
            fieldsLoadingState = .loading
            
            let getGlobalIndex = GetGlobalIndex(types: GlobalIndexType.allCases)
            
            try getGlobalIndexUseCase.execute(with: getGlobalIndex)
                .sink(receiveCompletion: handleGetGlobalsCompletion,
                      receiveValue: handleGetFieldsResult)
                .store(in: &cancellables)
        } catch {
            showToast(message: error.localizedDescription)
        }
    }
    
    func handleGetGlobalsCompletion(completion: Subscribers.Completion<UseCaseError>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print("Error: \(error)")
            showErrorToast(error: error)
            fieldsLoadingState = .failed
        }
    }
    
    func handleGetFieldsResult(result: DomainWrapper<GlobalIndex>) {
        fieldsLoadingState = .loaded
        
        if result.isSuccess,
           let studyingFields = result.data?.studyingFields,
           let locations = result.data?.locations,
           let types = result.data?.types {
            fields = studyingFields
            displayedFields = fields
            self.locations = locations
            self.educationStatuses = types
            self.getProfileData()
        } else {
            showErrorToast(message: result.message)
        }
    }
    
    func handleUseCaseFailure(error: UseCaseError) {
        fieldsLoadingState = .failed
    }
}

extension EditProfileViewModel {
    
    private func getProfileData() {
        profileDataLoadingState = .loading
        do {
            try getProfileDataUseCase.execute()
                .sink(receiveCompletion: handleGetProfileCompletion,
                      receiveValue: handleProfileDataResult)
                .store(in: &cancellables)
        } catch {
            showToast(message: error.localizedDescription)
        }
    }
    
    func handleGetProfileCompletion(completion: Subscribers.Completion<UseCaseError>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print("Error: \(error)")
            showErrorToast(error: error)
            profileDataLoadingState = .failed
        }
    }
    
    func handleProfileDataResult(result: DomainWrapper<ProfileData>) {
        profileDataLoadingState = .loaded
        
        if result.isSuccess, let profileData = result.data {
            self.profileData = profileData
            self.configureCountryCode()
            self.selectedField = profileData.field
            self.educationStatusSelected = profileData.type ?? .placeholder
            self.overView =  profileData.overview ?? ""
//            self.graduationYearSelected = GraduationYear(displayName: profileData.graduationYear, id: 1)
            self.locationSelected = profileData.location
        } else {
            showErrorToast(message: result.message)
        }
    }
}

extension EditProfileViewModel {
    
    func reloadLoadingState() {
        editProfileLoadingState = .loaded
    }
    
    private func editProfileData(editProfile: EditProfile) {
        editProfileLoadingState = .loading
        do {
            try editProfileUseCase.execute(with: editProfile)
                .sink(receiveCompletion: handleEditProfileCompletion,
                      receiveValue: handleEditProfileResult)
                .store(in: &cancellables)
        } catch {
            showToast(message: error.localizedDescription)
        }
    }
    
    func handleEditProfileCompletion(completion: Subscribers.Completion<UseCaseError>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print("Error: \(error)")
            showErrorToast(error: error)
            editProfileLoadingState = .failed
        }
    }
    
    func handleEditProfileResult(result: DomainWrapper<User>) {
        editProfileLoadingState = .loaded
        
        if result.isSuccess {
            showToast(message: result.message)
            coordinator.coordinateToBack()
        } else {
            showErrorToast(message: result.message)
        }
    }
}
