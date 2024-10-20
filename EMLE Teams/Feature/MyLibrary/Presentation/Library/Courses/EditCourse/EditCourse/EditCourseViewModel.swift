//
//  EditCourseViewModel.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 10/08/2024.
//

import Foundation
import EMLECore
import SwiftUI
import Combine

class EditCourseViewModel: MainViewModel {
    let coordinator: EditCourseViewCoordinating
    let courseId: Int
    
    init(courseId: Int,coordinator: EditCourseViewCoordinating) {
        self.courseId = courseId
        self.coordinator = coordinator
    }
    let dialogDeactivateCourseModel = CustomDialogModelConfigurator.configureModel(for: .deactivateCourse)
    let dialogDeleteCourseModel = CustomDialogModelConfigurator.configureModel(for: .deleteCourse)
    var isTabBarVisible: Bool { false }
    var isAllowOfflineWatching: Bool? = nil
    var cancellables = Set<AnyCancellable>()
    
    @Inject var contentDataUseCase: ContentDataUseCase
    @Inject var editCourseUseCase: EditCourseUseCase
    
    @Published var coueseData: Course?
    @Published var isCourseActive: Bool? = nil
    @Published var allowOfflineWatching: Bool? = nil
    @Published var isDeactivateCourseDialogViewPresented = false
    @Published var isDeleteCourseDialogViewPresented = false
    @Published var contentLoadingState: LoadingState = .loaded
}

extension EditCourseViewModel {
    func onAppear() {
        fetchContent(courseId: courseId)
    }
    
    func courseSetingTapped() {
        coordinator.goToCourseSetting(courseId: courseId)
    }
    
    func targetedLearnersTapped() {
        coordinator.goToTargetedView(courseId: courseId)
    }
    
    func protectionLayersTapped() {
        coordinator.goToProtectionLayerView(courseId: courseId, securityType: .course)
    }
    
    func visibilityTapped() {
        coordinator.goToVisiableView(courseId: courseId)
    }
    
    func deactivateCourseTapped() {
        withAnimation {
            isDeactivateCourseDialogViewPresented = true
        }
    }
    
    func onClickedDeactivateCourse() {
        withAnimation {
            isDeactivateCourseDialogViewPresented = false
        }
        if let isCourseActive = isCourseActive {
            updateCourse(status: isCourseActive ? 1 : 2, courseId: courseId)
        }
    }
    
    func allowOfflineWatchingTapped() {
        if let allowOfflineWatching = isAllowOfflineWatching {
            updateCourse(isAllowedOffline: allowOfflineWatching ? 0 : 1, courseId: courseId)
        }
    }

    func deleteCourseTapped() {
        withAnimation {
            isDeleteCourseDialogViewPresented = true
        }
    }
    
    func onClickedDeleteCourse() {
        withAnimation {
            isDeleteCourseDialogViewPresented = false
        }
        
        deleteCourse(courseId: courseId)
    }
}

// MARK: - get Content requests -

extension EditCourseViewModel {
    func fetchContent(courseId: Int) {
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
        
        if contentRequests.isSuccess {
            self.coueseData = contentRequests.data
            if let status = contentRequests.data?.status {
                self.isCourseActive = (status == 1)
            }
            if let allowOfflineWatching = contentRequests.data?.isAllowedOffline {
                self.allowOfflineWatching = allowOfflineWatching
                self.isAllowOfflineWatching = allowOfflineWatching
            }
        } else {
            print(contentRequests.message)
            showErrorToast(message: contentRequests.message)
        }
    }
}

// MARK: - Update Course -

extension EditCourseViewModel {
    func updateCourse(isAllowedOffline: Int? = nil, status: Int? = nil, courseId: Int) {
        do {
            let updateCourse = UpdateCourseFormDataRequest(status: status, isAllowedOffline: isAllowedOffline)
            let body: UpdateCourseParameter = UpdateCourseParameter(courseId: courseId, data: updateCourse)
            
            try editCourseUseCase.execute(params: body)
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
            fetchContent(courseId: courseId)
        } else {
            print(contentRequests.message)
            showErrorToast(message: contentRequests.message)
        }
    }
}

// MARK: - Delete Course -

extension EditCourseViewModel {
    func deleteCourse(courseId: Int) {
        do {
            let filters: DeleteCourseFilterRequest = .empty
            print(filters)
            let params = DeleteCourseDTO(filters: filters)
            
            try editCourseUseCase.deleteCourse(courseId: courseId, params: params)
                .sink(receiveCompletion: handleSecretriesCompletion,
                      receiveValue: handleDeleteCourseRequestsResult)
                .store(in: &cancellables)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func handleDeleteCourseRequestsResult(contentRequests: DomainWrapper<DeleteCourseResponse>) {
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

