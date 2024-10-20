//
//  CompleteYourProfileViewModel.swift
//  EMLE Learners
//
//  Created by Abdelrhman Sultan on 20/04/2024.
//

import Foundation
import EMLECore
import UIKit
import Combine

final class CompleteYourProfileViewModel: MainViewModel {
    
    enum Step: Int {
        case step1 = 0
        case step2 = 1
        case step3 = 2
        case step4 = 3
    }
    
    
    @Published var step: Step = .step1
    
    @Published var name = ""
    @Published var jobTitle = ""
    @Published var overView = ""
    
    
    @Published var profileImage: ImagePickerImage = .empty {
        didSet {
            didSelectImage = true
        }
    }
    
    @Published var educationStatusSelected: EducationStatus = .placeholder
    
    @Published var educationStatuses: [EducationStatus] = []
    
    @Published var graduationYearSelected: GraduationYear = .placeholder
    
    @Published var graduationYears: [GraduationYear] = []
    
    @Published var studyingFieldsSelected: StudyingField = .placeholder
    
    @Published var studyingFields: [StudyingField] = []
    
    @Published var imagePickerPresenting = false
    
    @Published var loadingState: LoadingState = .loaded
    
    @Published var fieldsLoadingState: LoadingState = .loaded
    
    @Published var displayedFields: [StudyingField] = []
    
    @Published var parentField: StudyingField?
    
    @Published var isPresentFieldsView = false
    
    @Published var isPresentGraduationYears = false
    
    @Published var isPresentEducationStatuses = false
    
    var isDoneButtonDisabled: Bool = false
    
    var isContinueDisable: Bool {
        if step == .step1 {
            return name.isEmpty
        } else if step == .step2 {
            return studyingFieldsSelected.fieldId == -1 || jobTitle.isEmpty
        } else if step == .step3 {
            return overView.isEmpty
        } else {
            return false
        }
    }
    
    var sourceType: ImagePickerSourceType = .photos
    
    var didSelectImage = false
    
    var cancellables = Set<AnyCancellable>()
    
    var coordinator: CompleteYourProfileCoordinating
    
    @Inject var register4UseCase: Register4UseCase
    @Inject var getGlobalIndexUseCase: GetGlobalIndexUseCase
    @Inject var changeUserUseCase: ChangeUserUseCase<User>
    @Inject var getUserUseCase: GetUserUseCase<User>
    
    init(coordinator: CompleteYourProfileCoordinating) {
        self.coordinator = coordinator
    }
}

extension CompleteYourProfileViewModel {
    
    func onAppear() {
        
        for year in 2000...2030 {
            graduationYears.append(GraduationYear(displayName: "\(year)", id: year - 1900 + 1))
        }
        
        getGlobals()
    }
    
    func onDisappear() { }
    
    func resetLoadingState() {
        loadingState = .loaded
    }
    
    func resetFieldsLoadingState() {
        fieldsLoadingState = .loaded
    }
    
    func onContinueClick() {
        
        switch step {
        case .step1:
            withOptionalAnimation {
                step = .step2
            }
        case .step2:
            withOptionalAnimation {
                step = .step3
            }
        case .step3:
            withOptionalAnimation {
                step = .step4
            }
        case .step4:
            let register4 = Register4(name: name,
                                      fieldId: studyingFieldsSelected.fieldId,
                                      typeId: educationStatusSelected.educationStatusId, image: didSelectImage ? profileImage.imageData : nil, jobTitle: jobTitle,overview: overView)
            
            completeProfileData(register4: register4)
        }
    }
    
    func onSkipClick() {
        withOptionalAnimation {
            step = .step3
        }
        didSelectImage = false
    }
    
    func onUploadPhotoClick() {
        sourceType = .photos
        imagePickerPresenting = true
    }
    
    func onTakePhotoClick() {
        sourceType = .camera
        imagePickerPresenting = true
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
    
    func selectField(field: StudyingField) {
        print(field.displayName)
        
        if !field.children.isEmpty {
            displayedFields = field.children
            parentField = field
        } else {
            isPresentFieldsView = false
        }
        
        studyingFieldsSelected = field
    }
    
    func onBackClick() {
        if let parentId = parentField?.parentId {
            parentField = getStudyingField(id: parentId, in: studyingFields)
        } else {
            parentField = nil
        }
        
        displayedFields = parentField?.children ?? studyingFields
    }
}

extension CompleteYourProfileViewModel {
    
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
}

extension CompleteYourProfileViewModel: UseCaseViewModel {
    
    private func completeProfileData(register4: Register4) {
        do {
            loadingState = .loading
            
            try register4UseCase.execute(with: register4)
                .sink(receiveCompletion: handleCompleteCompletion,
                      receiveValue: handleCompleteProfileDataResult)
                .store(in: &cancellables)
            
        } catch {
            showErrorToast(message: error.localizedDescription)
        }
    }
    
    private func handleCompleteCompletion(completion: Subscribers.Completion<UseCaseError>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print("Error: \(error)")
            showErrorToast(error: error)
            loadingState = .failed
        }
    }
    
    private func handleCompleteProfileDataResult(result: DomainWrapper<User>) {
        
        loadingState = .loaded
        
        if result.isSuccess, var user = result.data {
            @Inject var token: Token
//            @Inject var teamId: TeamId
            user.token = token
            user.type = educationStatusSelected
            user.studyingField = studyingFieldsSelected
            user.name = name
            changeUserUseCase.execute(with: user)
            coordinator.coordinateToCongrats()
        } else {
            showErrorToast(message: result.message)
        }
    }
    
    func handleUseCaseFailure(error: UseCaseError) {
        loadingState = .failed
        fieldsLoadingState = .failed
    }
}

extension CompleteYourProfileViewModel {
    
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
    
    private func handleGetGlobalsCompletion(completion: Subscribers.Completion<UseCaseError>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print("Error: \(error)")
            showErrorToast(error: error)
            fieldsLoadingState = .failed
        }
    }
    
    private func handleGetFieldsResult(result: DomainWrapper<GlobalIndex>) {
        fieldsLoadingState = .loaded
        
        if result.isSuccess,
           let studyingFields = result.data?.studyingFields,
           let types = result.data?.types {
            self.studyingFields = studyingFields
            displayedFields = studyingFields
            self.educationStatuses = types
        } else {
            showErrorToast(message: result.message)
        }
    }
}

