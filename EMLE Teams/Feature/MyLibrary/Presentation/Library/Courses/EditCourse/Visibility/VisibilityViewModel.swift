//
//  VisibilityViewModel.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 13/08/2024.
//

import Foundation
import EMLECore
import Combine

class VisibilityViewModel: MainViewModel {
    let coordinator: VisibilityViewCoordinating
    let courseId: Int
    
    init(courseId: Int, coordinator: VisibilityViewCoordinating) {
        self.coordinator = coordinator
        self.courseId = courseId
    }
    
    var isTabBarVisible: Bool { false }
    var cancellables = Set<AnyCancellable>()
    
    @Inject var contentDataUseCase: ContentDataUseCase
    @Inject var editCourseUseCase: EditCourseUseCase
    
    @Published var courseData: Course?
    @Published var selectedDateOption: VisibilityPublishType? = nil {
        didSet {
//            preprerSelectedFilters()
        }
    }
    @Published var publishDate: String = ""
    @Published var isPickerVisible: Bool = false
    @Published var contentLoadingState: LoadingState = .loaded
}

extension VisibilityViewModel {
    func onAppear() {
        fetchCourse(courseId: courseId)
    }
    
    func onApplyChangeClick() {
        updateCourse(courseId: courseId)
    }
    
    func onDiscardChangeClick() {
        coordinator.popView()
    }
}

// MARK: - get Content requests -

extension VisibilityViewModel {
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
        
        if contentRequests.isSuccess {
            self.courseData = contentRequests.data
            if let dateString = courseData?.publishAt, let formattedDate = convertDateToDisplayFormat(isoDate: dateString) {
                self.publishDate = formattedDate
            }
        } else {
            print(contentRequests.message)
            showErrorToast(message: contentRequests.message)
        }
    }
}

// MARK: - Update Course -

extension VisibilityViewModel {
    func updateCourse(courseId: Int) {
        do {
            let updateData = UpdateCourseFormDataRequest(publishAt: publishDate)
            let body: UpdateCourseParameter = UpdateCourseParameter(courseId: courseId, data: updateData)
            
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
            coordinator.popView()
        } else {
            print(contentRequests.message)
            showErrorToast(message: contentRequests.message)
        }
    }
}

extension VisibilityViewModel {
    func convertDateToDisplayFormat(isoDate: String) -> String? {
        let isoDateFormatter = ISO8601DateFormatter()
        isoDateFormatter.formatOptions = [.withFullDate, .withTime, .withDashSeparatorInDate, .withColonSeparatorInTime]
        
        if let date = isoDateFormatter.date(from: isoDate) {
            let displayDateFormatter = DateFormatter()
            displayDateFormatter.dateFormat = "MMM d, yyyy, h:mm a"
            return displayDateFormatter.string(from: date)
        } else {
            return nil
        }
    }
}
