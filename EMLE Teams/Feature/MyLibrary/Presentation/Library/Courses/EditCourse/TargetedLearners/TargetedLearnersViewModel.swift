//
//  TargetedLearnersViewModel.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 13/08/2024.
//

import Foundation
import EMLECore
import Combine
import SwiftUI

class TargetedLearnersViewModel: MainViewModel {
    let coordinator: TargetedLearnersViewCoordinating
    let courseId: Int
    
    init(courseId: Int, coordinator: TargetedLearnersViewCoordinating) {
        self.courseId = courseId
        self.coordinator = coordinator
    }
    
    var isTabBarVisible: Bool { false }
    var cancellables = Set<AnyCancellable>()
    var targets: [Target] = []
    
    var canAddNewTarget: Bool {
        !newTarget.name.isEmpty &&
        (!newTarget.field.displayName.isEmpty &&
         !newTarget.type.displayName.isEmpty && !newTarget.institution.displayName.isEmpty )
    }
    
    @Published var newTarget: Target = .placeholder
    
    @Published var courseData: Course?
    @Published var showOnCourseExplore: Bool = false
    @Published var isExpandableStates: [Bool] = []
    
    @Published var isAddTarget: Bool = false
    @Published var isShowPrice: Bool = true
    @Published var isShowStudentCount: Bool = true
    @Published var targetName: String = ""
    @Published var targetNumber: String = ""
    @Published var currentOption: TargetedLearnersType?
    @Published var currentIndex: Int? = nil
    @Published var isPresentCustomSheetView: Bool = false
    @Published var parentField: StudyingField?
    @Published var fields: [StudyingField] = []
    @Published var displayedFields: [StudyingField] = []
    @Published var selectedField: StudyingField = .emptyPlaceholder
    @Published var educationStatuses: [EducationStatus] = []
    @Published var educationStatusSelected: EducationStatus = .emptyPlaceholder
    @Published var institution: [Institution] = []
    @Published var selectedInstitution: Institution = .emptyPlaceholder
    
    @Published var fieldsLoadingState: LoadingState = .loaded
    @Published var contentLoadingState: LoadingState = .loaded
    
    
    @Inject var getGlobalIndexUseCase: GetGlobalIndexUseCase
    @Inject var contentDataUseCase: ContentDataUseCase
    @Inject var editCourseTargetUseCase: EditCourseTargetUseCase
}

extension TargetedLearnersViewModel {
    func onAppear() {
        fetchCourse(courseId: courseId)
        getGlobals()
    }
    
    func presentDialog(for option: TargetedLearnersType) {
        currentOption = option
        isPresentCustomSheetView = true
    }
    
    func onApplyChangeClick() {
        if !showOnCourseExplore {
            self.targets = []
        }
        
        updateCourse(courseId: self.courseId)
    }
    
    func onDiscardChangeClick() {
        coordinator.popView()
    }
    
    func addTargetTapped() {
        if !newTarget.name.isEmpty {
            targets.append(newTarget)
            showOnCourseExplore = true
            self.isExpandableStates = Array(repeating: true, count: self.targets.count)
            newTarget = .placeholder
        }
    }
    
    func onEductionClick() {
        
    }
    
    func onUniversityClick() {
        
    }
    
    func hideCustomSheetView() {
        isPresentCustomSheetView = false
        currentOption = nil
    }
    
    func onFieldsBackClick() {
        if let parentId = parentField?.parentId {
            
            parentField = StudyingField.getStudyingField(id: parentId, in: fields)
        } else {
            
            parentField = nil
        }
        
        displayedFields = parentField?.children ?? fields
    }
    
    func onFieldSelect(field: StudyingField) {
        if !field.children.isEmpty {
            displayedFields = field.children
            parentField = field
        } else {
            hideCustomSheetView()
            selectedField = field
            
            if let index = currentIndex {
                targets[index].field = field
            } else {
                newTarget.field = field
            }
        }
    }
    
    func onFieldsDoneClick(field: StudyingField) {
        selectedField = field
        hideCustomSheetView()
        
        if let index = currentIndex {
            targets[index].field = field
        } else {
            newTarget.field = field
        }
    }
    
    func onEducationStatusSelect(educationStatus: EducationStatus) {
        educationStatusSelected = educationStatus
        hideCustomSheetView()
        
        if let index = currentIndex {
            targets[index].type = educationStatus
        } else {
            newTarget.type = educationStatus
        }
    }
    
    func onInstitutionSelect(institution: Institution) {
        selectedInstitution = institution
        hideCustomSheetView()
        
        if let index = currentIndex {
            targets[index].institution = institution
        } else {
            newTarget.institution = institution
        }
    }
    
}

// MARK: - get Globals requests -

extension TargetedLearnersViewModel: UseCaseViewModel {
    
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
           let types = result.data?.types, let institution = result.data?.institutions {
            fields = studyingFields
            displayedFields = fields
            self.educationStatuses = types
            self.institution = institution
        } else {
            showErrorToast(message: result.message)
        }
    }
    
    func handleUseCaseFailure(error: UseCaseError) {
        fieldsLoadingState = .failed
    }
}

// MARK: - get Content requests -

extension TargetedLearnersViewModel {
    func fetchCourse(courseId: Int) {
        do {
            let filters: GetContentFilterRequest = .empty
            print(filters)
            
            try contentDataUseCase.execute(courseId: courseId)
                .sink(receiveCompletion: handleSecretriesCompletion,
                      receiveValue: handleContentRequestsResult)
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
            contentLoadingState = .failed
        }
    }
    
    func handleContentRequestsResult(contentRequests: DomainWrapper<Course>) {
        contentLoadingState = .loaded
        
        if contentRequests.isSuccess, let courseData = contentRequests.data {
            self.courseData = courseData
            self.targets = courseData.targets ?? []
            if let targets = courseData.targets {
                self.showOnCourseExplore = !targets.isEmpty
                self.isExpandableStates = Array(repeating: true, count: self.targets.count)
            } else {
                self.showOnCourseExplore = false
                //                self.isExpandable = false
            }
        } else {
            print(contentRequests.message)
            showErrorToast(message: contentRequests.message)
        }
    }
}

// MARK: - Update Course -

extension TargetedLearnersViewModel {
    func updateCourse(courseId: Int) {
        do {
            
            let body = EditCourseTargetParameter(courseId: courseId, targets: self.targets, displayPrice: isShowPrice ? 1 : 0, displayStudentsCount: isShowStudentCount ? 1 : 0)
            
            try editCourseTargetUseCase.execute(params: body)
                .sink(receiveCompletion: handleSecretriesCompletion,
                      receiveValue: handleUpdateFolderRequestsResult)
                .store(in: &cancellables)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func handleUpdateFolderRequestsResult(contentRequests: DomainWrapper<Course>) {
        contentLoadingState = .loaded
        
        if contentRequests.isSuccess {
            showSuccessToast(message: contentRequests.message)
            coordinator.popView()
        } else {
            print(contentRequests.message)
            showErrorToast(message: contentRequests.message)
        }
    }
}
