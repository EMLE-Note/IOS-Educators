//
//  CourseSettingViewModel.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 12/08/2024.
//

import Foundation
import EMLECore
import Combine
import SwiftUI

class CourseSettingViewModel: MainViewModel {
    let coordinator: CourseSettingViewCoordinating
    let courseId: Int
    
    init(courseId: Int, coordinator: CourseSettingViewCoordinating) {
        self.coordinator = coordinator
        self.courseId = courseId
    }
    
    var isTabBarVisible: Bool { false }
    var sourceType: ImagePickerSourceType = .photos
    var didSelectImage = false
    var cancellables = Set<AnyCancellable>()
    
    @Inject var contentDataUseCase: ContentDataUseCase
    @Inject var editCourseUseCase: EditCourseUseCase
    @Inject var getGroupUseCase: GetGroupUseCase
    @Inject var deleteGroupUseCase: DeleteGroupUseCase
    
    @Published var courseData: Course?
    @Published var selectedGroups: [GroupCourse] = [] {
        didSet {
            selectedGroupIds = selectedGroups.map { $0.groupId }
        }
    }
    @Published var allGroups: [GroupCourse] = []
    @Published var selectedGroupIds: [Int] = []
    @Published var rawCoursePrice: String = ""
    @Published var coursePrice: String = ""
    @Published var courseDataId = ""
    @Published var courseTitle = ""
    @Published var courseOverview = ""
    @Published var duration = ""
    @Published var group = ""
    @Published var imagePickerPresenting = false
    @Published var contentLoadingState: LoadingState = .loaded
    @Published var isPresentCustomSheetView: Bool = false
    @Published var courseImage: ImagePickerImage = .empty {
        didSet {
            didSelectImage = true
        }
    }
    
    var isApplyButtonEnabled: Bool {
        !courseDataId.isEmpty && !courseTitle.isEmpty && !coursePrice.isEmpty && !courseOverview.isEmpty && !duration.isEmpty
    }
}

extension CourseSettingViewModel {
    func onAppear() {
        fetchCourse(courseId: courseId)
    }
    
    func onChangeImageClick() {
        sourceType = .photos
        imagePickerPresenting = true
    }
    
    func onApplyChangeClick() {
        updateCourse(courseId: courseId)
    }
    
    func onDiscardChangeClick() {
        coordinator.popView()
    }
    
    func onRemoveGroupTapped(group: GroupCourse) {
        if let index = selectedGroups.firstIndex(where: { $0.groupId == group.groupId }) {
            selectedGroups.remove(at: index)
        }
    }
    
    func onSelectedNewGroupsTapped() {
        getGroups()
        withAnimation {
            isPresentCustomSheetView = true
        }
    }
    
    func updateCoursePrice(_ newValue: String) {
        var validPrice = newValue.filter { "0123456789".contains($0) }
        
        while validPrice.hasPrefix("0") && validPrice.count > 1 {
            validPrice.removeFirst()
        }
        
        if validPrice == "0" {
            validPrice = ""
        }
        
        if validPrice != rawCoursePrice {
            DispatchQueue.main.async {
                self.rawCoursePrice = validPrice
            }
        }
    }
    
//    func validateIdentifier(_ newValue: String) {
//        let filteredIdentifier = newValue.filter { $0.isLetter || $0.isNumber }
//        identifierIsValid = filteredIdentifier.count >= 4 && filteredIdentifier.count <= 10
//        DispatchQueue.main.async {
//            self.identifier = filteredIdentifier
//        }
//    }
}

// MARK: - get Content requests -

extension CourseSettingViewModel {
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
            if let courseId = courseData?.uuid, let courseTitle = courseData?.name, let price = courseData?.price, let currency = courseData?.currency, let overView = courseData?.overview, let duration = courseData?.duration {
                self.courseDataId = courseId
                self.courseTitle = courseTitle
                self.coursePrice = "\(price) \(currency)"
                self.courseOverview = overView
                self.duration = "\(duration)"
            }
            
            if let groups = courseData?.groups {
                self.selectedGroups = groups
            }
        } else {
            print(contentRequests.message)
            showErrorToast(message: contentRequests.message)
        }
    }
}

// MARK: - Update Course -

extension CourseSettingViewModel {
    func updateCourse(courseId: Int) {
        do {
            let updateCourse = UpdateCourseFormDataRequest(name: courseTitle, image: didSelectImage ? courseImage.imageData : nil, overview: courseOverview, duration: duration, price: Double(coursePrice), groups: selectedGroupIds)
            let body = UpdateCourseParameter(courseId: courseId, data: updateCourse)
            print(body)
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

// MARK: - Get Groups -

extension CourseSettingViewModel {
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
    
    func handleGroupsRequestsResult(groups: DomainWrapper<[GroupCourse]>) {
        contentLoadingState = .loaded
        
        if groups.isSuccess, let groups = groups.data {
            self.allGroups = groups
        } else {
            print(groups.message)
            showErrorToast(message: groups.message)
        }
    }
}

// MARK: - Delete Group -

extension CourseSettingViewModel {
    func deleteGroup(groupId: Int) {
        do {
            try deleteGroupUseCase.execute(groupId: groupId)
                .sink(receiveCompletion: handleSecretriesCompletion,
                      receiveValue: handleDeleteGroupResult)
                .store(in: &cancellables)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func handleDeleteGroupResult(group: DomainWrapper<DeleteGroupResponse>) {
        contentLoadingState = .loaded
        
        if group.isSuccess {
            showSuccessToast(message: group.message)
        } else {
            print(group.message)
            showErrorToast(message: group.message)
        }
    }
}

