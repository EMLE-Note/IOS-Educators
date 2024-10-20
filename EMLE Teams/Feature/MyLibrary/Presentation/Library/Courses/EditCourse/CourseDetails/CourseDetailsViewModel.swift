//
//  CousesDetailsViewModel.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 08/08/2024.
//

import Foundation
import EMLECore
import SwiftUI
import Combine

class CourseDetailsViewModel: MainViewModel {
    let coordinator: CourseDetailsViewCoordinating
    init(courseId: Int, coordinator: CourseDetailsViewCoordinating) {
        self.courseId = courseId
        self.coordinator = coordinator
    }

    var isParentFolder: Bool = false
    var selectedEnrollmentId: Int? = nil
    var selectedFolderId: Int? = nil
    var selectedIsActive: Bool = false
    let courseId: Int
    var isTabBarVisible: Bool { false }
    let options = [LibraryStrings.content.localized, LibraryStrings.student.localized]
    var cancellables = Set<AnyCancellable>()
    let dialogModel = CustomDialogModelConfigurator.configureModel(for: .deactivateLearner)
    let dialogDeleteFolderModel = CustomDialogModelConfigurator.configureModel(for: .deleteFolder)
    let dialogDeactivateAllModel = CustomDialogModelConfigurator.configureModel(for: .deactivateAll)
    var courseContentType: CousesDetailsType {
        CousesDetailsType(rawValue: selectedTap)!
    }
    var isAllDeactivated: Bool {
        return students.pageContent.allSatisfy { $0.status == 2 }
    }
    
    var buttonTitle: String {
        return isAllDeactivated ? LibraryStrings.activateAll.localized : LibraryStrings.deactivateAll.localized
    }

    @Published var contentOptions: [OptionType] = []
    @Published var studentOptions: [OptionType] = []
    
    @Inject var contentDataUseCase: ContentDataUseCase
    @Inject var studentDataUseCase: StudentDataUseCase
    
    @Published var contents: Course?
    @Published var students: PaginatedContent<[EnrollmentStudent]> = PaginatedContent([])
    @Published var searchEnrollmentsResults: [SearchResult<EnrollmentStudent>] = []
    @Published var contentLoadingState: LoadingState = .loaded
    @Published var studentLoadingState: LoadingState = .loaded
    @Published var isOptianContentViewPresented = false
    @Published var isOptianStudentViewPresented = false
    @Published var isDeactivateDialogViewPresented = false
    @Published var isDeactivateAllDialogViewPresented = false
    @Published var isDeleteDialogViewPresented = false
    @Published var isFilterStudentViewPresented = false
    @Published var isFinishSampleDialogPresented: Bool = true
    @Published var isShowEmptyView: Bool = false
    @Published var isShowContentEmptyView: Bool = false
    @Published var selectedTap: Int = 0
    @Published var searchText: String = "" {
        didSet {
            
        }
    }
    @Published var selectedDateOption: FilterStudentOptions? = nil {
        didSet {
            //            preprerSelectedFilters()
        }
    }
    @Published var selectedStatusTypes: Set<FilterStatusTypeOptions> = [] {
        didSet {
            //            preprerSelectedFilters()
        }
    }
}

// MARK: - Funcs -

extension CourseDetailsViewModel {
    func onAppear() {
        resetPages(cousesDetailsType: .all)
        fetchContent(contentType: .all)
    }
    
    func getStudents(){
        fetchStudent(page: students.nextPage)
    }
    
    func getNewStudents(){
        fetchStudent(page: students.nextPage)
    }
    
    func onFiltersClicked() {
        withOptionalAnimation {
            isFilterStudentViewPresented = true
        }
    }
    
    func deactivateAllTapped() {
        if isAllDeactivated {
            
        } else {
            
        }
    }
    
    func editCourseTapped() {
        coordinator.goToEditCourse(courseId: courseId)
    }
    
    func onClickedOptianContent(folderId: Int, isVisible: Bool) {
        withOptionalAnimation {
            isOptianContentViewPresented = true
        }
        selectedFolderId = folderId
        contentOptions = [
            .hideFolder(folderId: folderId, isVisible: isVisible),
            .deletePermanently(folderId: folderId)
        ]
    }
    
    private func addSearchSubscriber() {
        $searchText
            .removeDuplicates()
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.searchForResults()
            }
            .store(in: &cancellables)
    }
    
    private func prepereSearchSubscriber() {
        if searchEnrollmentsResults.isEmpty, searchEnrollmentsResults.isEmpty {
            addSearchSubscriber()
        }
    }
    
    private func searchForResults() {
        if !searchText.isEmpty {
            print("searchForResults for \(searchText) ")
//            searchEnrollments()
        }
    }
  
    func onClickedOptianStudent(enrollmentId: Int, isActive: Bool, security: Security) {
        selectedEnrollmentId = enrollmentId
        selectedIsActive = isActive
        withOptionalAnimation {
            isOptianStudentViewPresented = true
        }

        studentOptions = [
            .editSecurity(security: security),
            .toggleActivation(enrollmentId: enrollmentId, isActive: isActive)
        ]
    }
    
    func hideFolderTapped() {
        
    }
    
    func deletePermanentlyTapped(folderId: Int) {
        withAnimation {
            isOptianContentViewPresented = false
            isDeleteDialogViewPresented = true
        }
    }
    
    func editSecurityLayersTapped(security: Security) {
        isOptianContentViewPresented = false
        coordinator.goToProtectionLayerView(security: security, securityType: .student)
    }
    
    func deactivateTapped() {
        isDeactivateDialogViewPresented = false
        guard let enrollmentId = selectedEnrollmentId else { return }
        
        if selectedIsActive {
            deactiveStudent(enrollmentId: enrollmentId, status: 2)
        } else {
            deactiveStudent(enrollmentId: enrollmentId, status: 1)
        }
    }
    
    func deleteFolder() {
        withAnimation {
            isDeleteDialogViewPresented = false
        }
        guard let selectedFolderId = selectedFolderId else { return }
        deleteFolder(folderId: selectedFolderId)
    }
    
    func onApplyChangeClick() {
        
    }
    
    func onDiscardChangeClick() {
        isFilterStudentViewPresented = false
    }
    
    func onClickedCreateParentFolder() {
        let model = CustomDialogTextFieldModel(title: LibraryStrings.addNewParentFolder.localized, buttonTitle: LibraryStrings.createFolder.localized, dialogType: .parent)
        coordinator.goToCustomDialogTextField(model: model)
    }
    
    func onClickedCreateLessonFolder() {
        let model = CustomDialogTextFieldModel(title: LibraryStrings.addLessonFolder.localized, buttonTitle: LibraryStrings.createLessonFolder.localized, dialogType: .lesson)
        coordinator.goToCustomDialogTextField(model: model)
    }
    
    func onClickedShowChildernFolder(folderId: Int) {
        coordinator.goToChildernFolder(folderId: folderId)
    }
    
    func getDuration(to dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
        
        guard let futureDate = dateFormatter.date(from: dateString) else {
            return nil
        }
        
        let calendar = Calendar.current
        let currentDate = Date()
        
        let dayComponents = calendar.dateComponents([.day], from: currentDate, to: futureDate)
        let days = dayComponents.day ?? 0
        
        if days > 30 {
            let monthComponents = calendar.dateComponents([.month], from: currentDate, to: futureDate)
            let months = monthComponents.month ?? 0
            return "\(months) month"
        } else {
            return "\(days) days"
        }
    }
}

extension CourseDetailsViewModel {
    private func resetPages(cousesDetailsType: CousesDetailsType) {
        
        switch cousesDetailsType {
        case .content:
            return
        case .student:
            students.currentPage = 0
        case .all:
            students.currentPage = 0
        }
    }
    
    private func fetchContent(contentType: CousesDetailsType) {
        
        switch contentType {
        case .content:
            fetchContent(courseId: courseId)
        case .student:
            fetchStudent(page: students.nextPage)
        case .all:
            fetchContent(courseId: courseId)
            fetchStudent(page: students.nextPage)
        }
    }
}

// MARK: - ViewModel Handling

extension CourseDetailsViewModel {
    func handleAction(for option: OptionType) {
        switch option {
        case .hideFolder(let folderId, let isVisible):
            toggleHiddenFolder(folderId: folderId, isVisible: isVisible)
        case .deletePermanently(let folderId):
            deletePermanentlyTapped(folderId: folderId)
        case .editSecurity(security: let security):
            editSecurityLayersTapped(security: security)
        case .toggleActivation(let enrollmentId, let isActive):
            toggleActivation(enrollmentId: enrollmentId, isActive: isActive)
        }
    }
    
    private func toggleActivation(enrollmentId: Int, isActive: Bool) {
        withAnimation {
            isOptianStudentViewPresented = false
            isDeactivateDialogViewPresented = true
        }
    }
    
    private func toggleHiddenFolder(folderId: Int, isVisible: Bool) {
        withOptionalAnimation {
            isOptianContentViewPresented = false
        }
        if isVisible {
            updateFolder(isVisible: 0, folderId: folderId)
        } else {
            updateFolder(isVisible: 1, folderId: folderId)
        }
    }
}

// MARK: - get Content requests -

extension CourseDetailsViewModel {
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
            self.contents = contentRequests.data
            if let isEmpty = contents?.folders.isEmpty, !isEmpty {
                self.isShowContentEmptyView = false
            } else {
                self.isShowContentEmptyView = true
            }
            if let folders = contents?.folders {
                let type = folders.compactMap { $0.type }
                if let firstCallType = type.first(where: { $0 == .parent || $0 == .lessons }) {
                    self.isParentFolder = (firstCallType == .parent)
                }
            }
        } else {
            print(contentRequests.message)
            showErrorToast(message: contentRequests.message)
        }
    }
}

// MARK: - get Student requests -

extension CourseDetailsViewModel {
    func fetchStudent(page: Page) {
        guard studentLoadingState != .loading else { return }
        do {
            if students.isAtFirstPage {
                studentLoadingState = .loading
                students.pageContent = .placeholder
            }
            
            let filters: GetStudentFilterRequest = .empty
            let params = GetStudents(filters: filters)
            print(filters)
            
            try studentDataUseCase.execute(couresId: courseId, request: params)
                .sink(receiveCompletion: handleStudentCompletion,
                      receiveValue: handleCoursesResult)
                .store(in: &cancellables)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func handleStudentCompletion(completion: Subscribers.Completion<UseCaseError>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print("Error: \(error)")
            showErrorToast(error: error)
            studentLoadingState = .failed
            students.pageContent = []
        }
    }
    
    func handleCoursesResult(CoursesPage: DomainWrapper<EnrollmentResponse>) {
        studentLoadingState = .loaded
        
        if students.isAtFirstPage {
            students.pageContent = []
        }
        
        if CoursesPage.isSuccess, let CoursePage = CoursesPage.data {
            if students.isAtFirstPage {
                if CoursePage.pagination.pageContent.count == 0 {
                    isShowEmptyView = true
                }
                students = CoursePage.pagination
                
            } else {
                students = students.withPaginationValues(of: CoursePage.pagination)
                
                students.pageContent.append(contentsOf: CoursePage.pagination.pageContent)
            }
            
        } else {
            print(CoursesPage.message)
            showErrorToast(message: CoursesPage.message)
        }
    }
}

// MARK: - Deactive Student -

extension CourseDetailsViewModel {
    func deactiveStudent(enrollmentId: Int, status: Int) {
        do {
            let body: UpdateEnrollmentStudentParameter = UpdateEnrollmentStudentParameter(enrollmentId: enrollmentId, status: status, method: "put")
            
            try studentDataUseCase.execute(enrollmentId: enrollmentId, params: body)
                .sink(receiveCompletion: handleSecretriesCompletion,
                      receiveValue: handleDeactiveRequestsResult)
                .store(in: &cancellables)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func handleDeactiveRequestsResult(contentRequests: DomainWrapper<UpdateEnrollmentStudentsResponse>) {
        contentLoadingState = .loaded
        
        if contentRequests.isSuccess {
            showSuccessToast(message: contentRequests.message)
            resetPages(cousesDetailsType: .all)
            fetchStudent(page: students.nextPage)
        } else {
            print(contentRequests.message)
            showErrorToast(message: contentRequests.message)
        }
    }
}

// MARK: - Update Folder -

extension CourseDetailsViewModel {
    func updateFolder(isVisible: Int, folderId: Int) {
        do {
            let body: UpdateFolderParameter = UpdateFolderParameter(folderId: folderId, isVisible: isVisible)
            
            try contentDataUseCase.updateFolder(folderId: folderId, params: body)
                .sink(receiveCompletion: handleSecretriesCompletion,
                      receiveValue: handleUpdateFolderRequestsResult)
                .store(in: &cancellables)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func handleUpdateFolderRequestsResult(contentRequests: DomainWrapper<ChildrenFolder>) {
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

// MARK: - Update Folder -

extension CourseDetailsViewModel {
    func deleteFolder(folderId: Int) {
        do {
            let filters: DeleteFolderFilterRequest = .empty
            print(filters)
            let params = DeleteFolderDTO(filters: filters)
            
            try contentDataUseCase.deleteFolder(folderId: folderId, params: params)
                .sink(receiveCompletion: handleSecretriesCompletion,
                      receiveValue: handleDeleteFolderRequestsResult)
                .store(in: &cancellables)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func handleDeleteFolderRequestsResult(contentRequests: DomainWrapper<DeleteFolderResponse>) {
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
