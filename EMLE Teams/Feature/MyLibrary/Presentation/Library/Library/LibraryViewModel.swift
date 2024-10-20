//
//  LibraryViewModel.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 07/08/2024.
//

import SwiftUI
import EMLECore
import Combine

class LibraryViewModel: MainViewModel {
    
    let coordinator: LibraryViewCoordinating
    
    init(coordinator: LibraryViewCoordinating) {
        self.coordinator = coordinator
    }
    
    var isTabBarVisible: Bool { true }
    let options = [LibraryStrings.course.localized, LibraryStrings.EBooks.localized, LibraryStrings.QBank.localized, LibraryStrings.drafts.localized]
    let privacy: PrivacyOptions = .Private
    var cancellables = Set<AnyCancellable>()

    var libarayType: LibarayTypeType {
        LibarayTypeType(rawValue: selectedTap)!
    }
    
    var isCreateButtonEnabled: Bool {
        !groupName.isEmpty
    }

    @Inject var libraryUseCase: LibraryDataUseCase
    @Inject var createGroupUseCase: CreateGroupUseCase
    @Inject var qBankUseCase: QBankUseCase

    @Published var selectedTap: Int = 0
    @Published var coursesData: PaginatedContent<[Course]> = PaginatedContent([])
    @Published var coursesLoadingState: LoadingState = .loaded
    @Published var isAddGroupViewPresented = false
    @Published var groupName = ""
    
    // QBank
    @Published var qBank: PaginatedContent<[QBank]> = PaginatedContent([])
    @Published var qBankLoadingState: LoadingState = .loaded
    @Published var isOptianQBankViewPresented = false
    @Published var qbankOptions: [QBankOptionType] = []
}

// MARK: - Func

extension LibraryViewModel {
    func onAppear() {
        resetPages(libarayType: .all)
        fetchContent(libarayType: .all)
    }
    
    func getCourses(){
        getCourses(page: coursesData.nextPage)
    }
    
    func getNewCourses(){
        getCourses(page: coursesData.nextPage)
        print("Nexttt", coursesData.nextPage)
    }
    
    func getNewQBank() {
        fetchQBank(page: qBank.nextPage)
    }
    
    func onCardTapped(_ courseId: Int) {
        coordinator.goToCourseDetails(courseId: courseId)
    }
    
    func onAddNewCourseTapped() {
        coordinator.goToCreateNewCourse()
    }
    
    func onAddNewGroupTapped() {
        withAnimation {
            isAddGroupViewPresented = true
        }
    }
    
    func onCreateNewGroupTapped() {
        withAnimation {
            isAddGroupViewPresented = false
        }
        createGroup()
    }
    
    func onClickedOptianQBank(qbankId: Int) {
        withOptionalAnimation {
            isOptianQBankViewPresented = true
        }

        qbankOptions = [
            .editQuestion(questionId: qbankId),
            .deleteQuestion(questionId: qbankId)
        ]
    }
}

// MARK: - QBank -

extension LibraryViewModel {
    func addNewQBankTapped() {
        coordinator.goToAddNewQBank()
    }
}

extension LibraryViewModel {
    private func resetPages(libarayType: LibarayTypeType) {
        
        switch libarayType {
        case .course:
            coursesData.currentPage = 0
        case .eBook:
            return
        case .qBank:
            qBank.currentPage = 0
        case .drafts:
            return
        case .all:
            coursesData.currentPage = 0
        }
    }
    
    private func fetchContent(libarayType: LibarayTypeType) {
        
        switch libarayType {
        case .course:
            getCourses(page: coursesData.nextPage)
        case .eBook:
            return
        case .qBank:
            fetchQBank(page: qBank.nextPage)
        case .drafts:
            return
        case .all:
            getCourses(page: coursesData.nextPage)
            fetchQBank(page: qBank.nextPage)
        }
    }
}

extension LibraryViewModel {
    func handleAction(for option: QBankOptionType) {
        switch option {
        case .editQuestion(questionId: let qbankId):
            editQuestionTapped(qbankId: qbankId)
        case .deleteQuestion(questionId: let qbankId):
            deletePermanentlyTapped(qbankId: qbankId)
        }
    }
    
    private func editQuestionTapped(qbankId: Int) {
        withAnimation {
            isOptianQBankViewPresented = false
        }
        coordinator.goToEditQBank(qbankId: qbankId)
    }
    
    private func deletePermanentlyTapped(qbankId: Int) {
        
    }
}

extension LibraryViewModel {
    func getCourses(page: Page) {
        guard coursesLoadingState != .loading else { return }
        do {
            if coursesData.isAtFirstPage {
                coursesLoadingState = .loading
                coursesData.pageContent = .placeholder
            }
            
            let filters: GetCoursesFilterRequest = .empty
            print(filters)
            let params = GetCourses(filters: filters)
            
            try libraryUseCase.execute(params: params)
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
            coursesLoadingState = .failed
            coursesData.pageContent = []
        }
    }
    
    func handleCoursesResult(CoursesPage: DomainWrapper<PaginatedContent<[Course]>>) {
        coursesLoadingState = .loaded

        if coursesData.isAtFirstPage {
            coursesData.pageContent = []
        }
        
        if CoursesPage.isSuccess, let CoursePage = CoursesPage.data {
            if coursesData.isAtFirstPage {
                
                coursesData = CoursePage
                print("First Page", coursesData)
            } else {
                coursesData = coursesData.withPaginationValues(of: CoursePage)
                
                coursesData.pageContent.append(contentsOf: CoursePage.pageContent)
                
                print("New Page", coursesData)
            }
            
        } else {
            print(CoursesPage.message)
            showErrorToast(message: CoursesPage.message)
        }
    }
}

// MARK: - get Content requests -

extension LibraryViewModel {
    func createGroup() {
        do {
            
            let createGroup = CreateGroup(name: groupName)
            try createGroupUseCase.execute(params: createGroup)
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
            coursesLoadingState = .failed
        }
    }
    
    func handleContentRequestsResult(result: DomainWrapper<GroupResponse>) {
        coursesLoadingState = .loaded
        
        if result.isSuccess {
            showSuccessToast(message: result.message)
            
        } else {
            print(result.message)
            showErrorToast(message: result.message)
        }
    }
}

// MARK: - Fetch Q-Bank -

extension LibraryViewModel {
    func fetchQBank(page: Page) {
        guard qBankLoadingState != .loading else { return }
        
        do {
            if qBank.isAtFirstPage {
                qBankLoadingState = .loading
                qBank.pageContent = .placeholder
            }
            
            let filters: GetQBankFilterRequest = .empty
            print(filters)
            let params = GetQBank(filters: filters)
            
            try qBankUseCase.execute(params: params)
                .sink(receiveCompletion: handleTransactionsCompletion,
                      receiveValue: handleQBankResult)
                .store(in: &cancellables)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    func handleQBankResult(qbank: DomainWrapper<QBankResponse>) {
        qBankLoadingState = .loaded

        if qBank.isAtFirstPage {
            coursesData.pageContent = []
        }
        
        if qbank.isSuccess, let qbank = qbank.data {
            if coursesData.isAtFirstPage {
                qBank = qbank.pagination
            } else {
                qBank = qBank.withPaginationValues(of: qbank.pagination)
                
                qBank.pageContent.append(contentsOf: qbank.pagination.pageContent)
            }
            
        } else {
            print(qbank.message)
            showErrorToast(message: qbank.message)
        }
    }
}
