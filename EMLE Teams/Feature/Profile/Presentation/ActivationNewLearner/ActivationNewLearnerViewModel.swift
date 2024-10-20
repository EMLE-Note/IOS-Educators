//
//  ActivationNewLearnerViewModel.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 13/10/2024.
//

import Foundation
import EMLECore
import SwiftUI
import Combine
import CountryPicker

class ActivationNewLearnerViewModel: MainViewModel {
    
    var isTabBarVisible: Bool { false }
    var cancellables = Set<AnyCancellable>()
    let coordinator: ActivationNewLearnerCoordinating
    init(coordinator: ActivationNewLearnerCoordinating) {
        self.coordinator = coordinator
    }
    
    var fullPhoneNumber: String {
        if !phoneNumber.isEmpty, phoneNumber.first == "0" {
            
            var phone = phoneNumber
            phone.removeFirst()
            
            return "+" + country.phoneCode + phone
        } else {
            
            return "+" + country.phoneCode + phoneNumber
        }
    }
    
    @Published var activationLoadingState: LoadingState = .loaded
    @Published var selectedCountry: String = ""
    @Published var isPresentingCountryCodePicker: Bool = false
    @Published var isPresentCustomSheetView: Bool = false
    @Published var isSelectedGroupView: Bool = false
    @Published var isUseSpecialToggle: Bool = false
    @Published var isDialogContentPresented: Bool = false
    @Published var country = Country(isoCode: "EG")
    @Published var phoneNumber: String = "" {
        didSet {
            validatePhone()
        }
    }
    @Published var phoneNumberChecker: ViewChecker = ViewChecker(state: .empty, messages: [.wrong : RegistrationStrings.incorrectPhoneText.localized])
    @Published var currentOption: ActivationType?
    
    @Published var materialTypeSelected: ActivationMaterialType = .course
    @Published var selectedMaterialType: ActivationMaterialType = .placeholder
    @Published var materialType: [ActivationMaterialType] = ActivationMaterialType.allCases
    
    @Published var searchData: SearchStaffResponse? = nil
    @Published var isFoundUserSearch: Bool = false
    @Published var isBorder = false
    @Published var phoneNumberVisible: Bool = true
    
    @Published var selectedMaterialName: ActivationMaterialName = .placeholder
    @Published var materialName: [ActivationMaterialName] = []
    
    @Published var allGroups: [GroupCourse] = []
    @Published var groupCourses: [Course] = []
    @Published var selectedGroupCourses: [Course] = []
    @Published var selectedGroupName: String?
    @Published var isAllCoursesSelected: Bool = false
    @Published var selectedCourses: [Course] = []
    
    @Published var locationSelected: Location = .placeholder
    @Published var locations: [Location] = []
    
    @Published var specialPrice: String = ""
    @Published var reasons: String = ""
    @Published var priceAmount: String = ""
    
    @Inject var getGlobalIndexUseCase: GetGlobalIndexUseCase
    @Inject var courseUseCase: LibraryDataUseCase
    @Inject var qbankUseCase: QBankUseCase
    @Inject var getGroupUseCase: GetGroupUseCase
    @Inject var searchStaffUseCase: SearchStaffUseCase
    @Inject var createEnrollmentCourseUseCase: CreateEnrollmentCourseUseCase
    @Inject var createEnrollmentQBankUseCase: CreateEnrollmentQBankUseCase
    @Inject var createEnrollmentEBookUseCase: CreateEnrollmentEBookUseCase
    @Inject var createEnrollmentMassCourseUseCase: CreateEnrollmentMassCourseUseCase
    
    var isActivateButtonEnabled: Bool {
        if materialTypeSelected == .group {
            return !selectedMaterialType.displayName.isEmpty && !selectedMaterialName.displayName.isEmpty
        }
        return !selectedMaterialType.displayName.isEmpty && !selectedMaterialName.displayName.isEmpty && !priceAmount.isEmpty
    }
}

extension ActivationNewLearnerViewModel {
    func onAppear() {
        getGlobals()
        configureCountryCode()
    }
    
    private func validatePhone() {
        if fullPhoneNumber.isEmpty {
            phoneNumberChecker.state = .empty
        }
        else {
            phoneNumberChecker.state = fullPhoneNumber.isValidPhone() ? .correct : .wrong
        }
    }
    
    func countryCodeClick() {
        isPresentingCountryCodePicker = true
    }
    
    func setCountryCode(country: Country) {
        
        self.country = country
        
        isPresentingCountryCodePicker = false
        
        validatePhone()
        
        setCountryPhoneCode()
    }
    
    private func setCountryPhoneCode() {
        
        selectedCountry = RegistrationStrings.phoneCodeSS.localizedFormat(arguments: country.isoCode.getFlag(), "+\(country.phoneCode)")
    }
    
    func presentDialog(for option: ActivationType) {
        currentOption = option
        isPresentCustomSheetView = true
    }
    
    func onLocationSelect(location: Location) {
        
        locationSelected = location
        
        withAnimation {
            isPresentCustomSheetView = false
        }
        
    }
    
    func onMaterialSelect(name: ActivationMaterialName) {

        selectedMaterialName = name
        
        withAnimation {
            isPresentCustomSheetView = false
        }
        
        if selectedMaterialType == .group {
            selectCourse(withId: name.id)
            withAnimation {
                isDialogContentPresented = true
            }
        }
    }
    
    func selectMaterialType(_ activationMaterialType: ActivationMaterialType) {
        switch activationMaterialType {
        case .course:
            getCourses()
            isSelectedGroupView = false
        case .ebook:   return
        case .qbank:
            fetchQBank()
            isSelectedGroupView = false
        case .group:
            getGroups()
            isSelectedGroupView = true
        case .placeholder:
            return
        }
        selectedMaterialName = .placeholder
        materialTypeSelected = activationMaterialType
        withAnimation {
            isPresentCustomSheetView = false
        }
    }
    
    private func configureCountryCode() {
        
        if let countryCode = (Locale.current as NSLocale).object(forKey: .countryCode) as? String {
            
            country = Country(isoCode: countryCode)
            setCountryPhoneCode()
        }
        
    }
    
    func toggleBorder() {
        isBorder.toggle()
    }
    
    func checkUserName() {
        if let name = searchData?.name, !name.isEmpty {
            phoneNumberVisible = false
        } else {
            phoneNumberVisible = true
        }
    }
    
    func toggleSelectAllCourses() {
        isAllCoursesSelected.toggle()
        
        if isAllCoursesSelected {
            selectedCourses = selectedGroupCourses
        } else {
            selectedCourses.removeAll()
        }
    }
    
    func toggleCourseSelection(_ course: Course, isChecked: Bool) {
        if isChecked {
            if !selectedCourses.contains(where: { $0.id == course.id }) {
                selectedCourses.append(course)
            }
        } else {
            selectedCourses.removeAll { $0.id == course.id }
        }
        
        if !isChecked {
            isAllCoursesSelected = false
        }
    }
    
    func isCourseSelectedBinding(course: Course) -> Binding<Bool> {
        Binding<Bool>(
            get: {
                self.selectedCourses.contains(where: { $0.id == course.id })
            },
            set: { isChecked in
                self.toggleCourseSelection(course, isChecked: isChecked)
            }
        )
    }
    
    func selectedCourseTapped() {
        withAnimation {
            isDialogContentPresented = false
        }
    }
}

extension ActivationNewLearnerViewModel {
    func searchTapped() {
        
        var mobile = phoneNumber
        
        if !phoneNumber.isEmpty, phoneNumber.first == "0" {
            
            mobile.removeFirst()
        }
        
        let searchModel = SearchStaff(mobileCode: "+\(country.phoneCode)", mobile: mobile)
        isFoundUserSearch = false
        searchStaff(searchStaff: searchModel)
    }
    
    func cancelTapped() {
        
    }
    
    func activateTapped() {
        switch materialTypeSelected {
        case .course:
            createEnrollmentCourse()
        case .qbank:
            createEnrollmentQBank()
        case .ebook:
            break
        case .group:
            createEnrollmentMassCourse()
        case .placeholder:
            break
        }
    }
}

extension ActivationNewLearnerViewModel: UseCaseViewModel {
    
    private func getGlobals() {
        do {
            activationLoadingState = .loading
            
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
            activationLoadingState = .failed
        }
    }
    
    func handleGetFieldsResult(result: DomainWrapper<GlobalIndex>) {
        activationLoadingState = .loaded
        
        if result.isSuccess,
           let locations = result.data?.locations {
            self.locations = locations
        } else {
            showErrorToast(message: result.message)
        }
    }
    
    func handleUseCaseFailure(error: UseCaseError) {
        activationLoadingState = .failed
    }
}

extension ActivationNewLearnerViewModel {
    func getCourses() {
        guard activationLoadingState != .loading else { return }
        do {
            let filters: GetCoursesFilterRequest = .empty
            print(filters)
            let params = GetCourses(filters: filters)
            
            try courseUseCase.execute(params: params)
                .sink(receiveCompletion: handleTransactionsCompletion,
                      receiveValue: handleCoursesResult)
                .store(in: &cancellables)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func handleTransactionsCompletion(completion: Subscribers.Completion<UseCaseError>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print("Error: \(error)")
            showErrorToast(error: error)
            activationLoadingState = .failed
        }
    }
    
    func handleCoursesResult(coursePage: DomainWrapper<PaginatedContent<[Course]>>) {
        activationLoadingState = .loaded

        if coursePage.isSuccess, let coursePage = coursePage.data {
            self.materialName = coursePage.pageContent.map { course in
                ActivationMaterialName(id: course.courseId, name: course.name)
            }
            
        } else {
            print(coursePage.message)
            showErrorToast(message: coursePage.message)
        }
    }
}

// MARK: - Fetch Q-Bank -

extension ActivationNewLearnerViewModel {
    func fetchQBank() {
        guard activationLoadingState != .loading else { return }
        
        do {
            
            let filters: GetQBankFilterRequest = .empty
            print(filters)
            let params = GetQBank(filters: filters)
            
            try qbankUseCase.execute(params: params)
                .sink(receiveCompletion: handleTransactionsCompletion,
                      receiveValue: handleQBankResult)
                .store(in: &cancellables)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    func handleQBankResult(qbanks: DomainWrapper<QBankResponse>) {
        activationLoadingState = .loaded
        
        if qbanks.isSuccess, let qbanks = qbanks.data {
            self.materialName = qbanks.qbanks.map { qbank in
                ActivationMaterialName(id: qbank.qBankId, name: qbank.name)
            }
        } else {
            print(qbanks.message)
            showErrorToast(message: qbanks.message)
        }
    }
}

extension ActivationNewLearnerViewModel {
    func getGroups() {
        do {
            try getGroupUseCase.execute()
                .sink(receiveCompletion: handleSecretriesCompletion,
                      receiveValue: handleGroupsRequestsResult)
                .store(in: &cancellables)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func handleSecretriesCompletion(completion: Subscribers.Completion<UseCaseError>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print("Error: \(error)")
            showErrorToast(error: error)
            activationLoadingState = .failed
        }
    }
    
    func handleGroupsRequestsResult(groups: DomainWrapper<[GroupCourse]>) {
        activationLoadingState = .loaded
        
        if groups.isSuccess, let groups = groups.data {
            self.materialName = groups.map { groups in
                ActivationMaterialName(id: groups.groupId, name: groups.name)
            }
            
            self.groupCourses = groups.flatMap { $0.courses ?? [] }
            self.allGroups = groups
            
        } else {
            print(groups.message)
            showErrorToast(message: groups.message)
        }
    }
    
    func selectCourse(withId courseId: Int) {
        if let selectedCourse = allGroups.first(where: { $0.groupId == courseId }) {
            self.selectedGroupCourses = selectedCourse.courses ?? []
            self.selectedGroupName = selectedCourse.name
        } else {
            print("Course not found.")
        }
    }
}

extension ActivationNewLearnerViewModel {
    private func searchStaff(searchStaff: SearchStaff) {
        guard activationLoadingState != .loading else { return }
        
        do {
            
            let params = SearchStaffParameter(data: searchStaff)
            
            try searchStaffUseCase.execute(parms: params)
                .sink(receiveCompletion: handleSearchCompletion,
                      receiveValue: handleSearchResult)
                .store(in: &cancellables)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    func handleSearchResult(search: DomainWrapper<SearchStaffResponse>) {
        activationLoadingState = .loaded
        
        if search.isSuccess, let search = search.data {
            self.isFoundUserSearch = true
            self.searchData = search
        } else {
            print(search.message)
            showErrorToast(message: search.message)
        }
    }
    
    func handleSearchCompletion(completion: Subscribers.Completion<UseCaseError>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print("Error: \(error)")
            showErrorToast(error: error)
            activationLoadingState = .failed
            self.isFoundUserSearch = true
        }
    }
}

extension ActivationNewLearnerViewModel {
    func createEnrollmentCourse() {
        guard activationLoadingState != .loading else { return }
        
        do {
            
            let params = EnrollmentCourse(studentId: searchData?.id, courseId: selectedMaterialName.id, paidAmount: Int(priceAmount), locationId: locationSelected.locationId, notes: reasons, price: Int(specialPrice))
            
            try createEnrollmentCourseUseCase.execute(parms: params)
                .sink(receiveCompletion: handleTransactionsCompletion,
                      receiveValue: handleEnrollmentCourseResult)
                .store(in: &cancellables)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func createEnrollmentQBank() {
        guard activationLoadingState != .loading else { return }
        
        do {
            
            let params = EnrollmentCourse(studentId: searchData?.id, courseId: selectedMaterialName.id, paidAmount: Int(priceAmount), locationId: locationSelected.locationId, notes: reasons, price: Int(specialPrice))
            
            try createEnrollmentQBankUseCase.execute(parms: params)
                .sink(receiveCompletion: handleTransactionsCompletion,
                      receiveValue: handleEnrollmentCourseResult)
                .store(in: &cancellables)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func handleEnrollmentCourseResult(course: DomainWrapper<EnrollmentManualResponse>) {
        activationLoadingState = .loaded
        
        if course.isSuccess {
            showSuccessToast(message: course.message)
            coordinator.dismiss()
        } else {
            print(course.message)
            showErrorToast(message: course.message)
        }
    }
    
    func createEnrollmentMassCourse() {
        guard activationLoadingState != .loading else { return }
        
        do {
            let studentId: Int = searchData?.id ?? 0
            let paidAmount: Int = 100

            var enrollmentMassCourses: [EnrollmentMassCourse] = []

            for course in selectedCourses {
                let data = EnrollmentMassCourse(studentId: studentId, courseId: course.courseId, paidAmount: paidAmount, price: Int(course.price))
                enrollmentMassCourses.append(data)
            }
            
            let params = EnrollmentCourseParameter(data: enrollmentMassCourses)
            
            try createEnrollmentMassCourseUseCase.execute(parms: params)
                .sink(receiveCompletion: handleTransactionsCompletion,
                      receiveValue: handleEnrollmentCourseResult)
                .store(in: &cancellables)
        } catch {
            print(error.localizedDescription)
        }
    }
}
