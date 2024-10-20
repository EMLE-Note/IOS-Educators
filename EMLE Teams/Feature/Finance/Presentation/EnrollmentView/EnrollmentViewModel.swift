//
//  EnrollmentViewModel.swift
//  EMLE Teams
//
//  Created by iOSAYed on 07/08/2024.
//

import Foundation
import Combine
import EMLECore
import SwiftUI

final class EnrollmentViewModel: MainViewModel {
    let coordinator: EnrollmentViewCoordinating
    var searchViewCoordinator: SearchViewCoordinator
    init(coordinator: EnrollmentViewCoordinating) {
        self.coordinator = coordinator
        self.searchViewCoordinator = SearchViewCoordinator(navigationController: coordinator.navigationController, tabBarController: coordinator.tabBarController)
    }

    var isTabBarVisible: Bool { false }
    var cancellables = Set<AnyCancellable>()
    
    let currancy = SharedData.shared.currancy.code ?? ""
    
    @Published var screenType: ScreenType = .content
    @Published var enrollmentOptions: EnrollmentOptions = .details
    @Published var enrollmentCoursesList: PaginatedContent<[Enrollment]> = PaginatedContent([])
    @Published var searchEnrollmentsResults: [SearchResult<Enrollment>] = []
    @Published var selectedEnrollment: Enrollment = .placeholder
    @Published var filterOptions: EnrollmentFilterOptions = .empty
    @Published var declineDebitValue: String = ""
    @Published var enrollmentLoadingState: LoadingState = .loaded
    @Published var isEnrollmentOptionsViewPresented: Bool = false
    @Published var isDeclineOptionsViewPresented: Bool = false
    @Published var declineCourseLoadingState: LoadingState = .loaded
    @Published var searchLoadingState: LoadingState = .loaded
    @Published var isDialogPresent: Bool = false
    @Published var isShowEmptyView: Bool = false
    
    @Published var searchText: String = "" {
        willSet {
            if newValue != searchText && !newValue.isEmpty {
                searchLoadingState = .loading
                searchEnrollmentsResults = .placeholder
            }
        }
    }

    @Inject var enrollmentUseCase: EnrollmentUseCase
}

// MARK: Private Functions

extension EnrollmentViewModel {
    private func showDialog(option: EnrollmentOptions) {
        enrollmentOptions = option
        isEnrollmentOptionsViewPresented = false
        isDialogPresent = true
    }
    
    private func resetPages() {
        enrollmentCoursesList.currentPage = 0
    }
    
    private func getEnrollmentCourses() {
        resetPages()
        getEnrollmentCourses(page: enrollmentCoursesList.nextPage)
    }
    
    private var filtersApplied: Bool {
        return filterOptions.isSelected
    }
    
    func goToEnrollmentDetails() {
        isEnrollmentOptionsViewPresented = false
        coordinator.goToEnrollmentDetails(enrollmentDetails: selectedEnrollment)
    }
    
    private func resolveEnrollment() {
        isDialogPresent = false
        declineCourse(enrollmentId: selectedEnrollment.enrollmentId, paidAmount: "\(selectedEnrollment.remained)")
    }
}

// MARK: Filter logic

extension EnrollmentViewModel {
    private func changeScreenType(to type: ScreenType) {
        withOptionalAnimation {
            screenType = type
        }
    }
    
    private func displayEnrollmentScreen() {
        changeScreenType(to: .content)
    }
    
    private func displayFiltersScreen() {
        changeScreenType(to: .filters)
    }

    private func displaySearchScreen() {
        changeScreenType(to: .search)
    }
    
    func onFiltersClose() {
        displayEnrollmentScreen()
        isShowEmptyView = false
        enrollmentCoursesList = PaginatedContent([])
        let filters = prepareEnrollmentContentFilters(contentFilters: filterOptions)
        print(filters)
        getEnrollmentCourses()
    }
    
    private func prepareEnrollmentContentFilters(contentFilters: EnrollmentFilterOptions) -> EnrollmentContentFilter {
        var filters: EnrollmentContentFilter = .empty
        
        filters.enrollmentType = contentFilters.enrollmentType.map {
            switch $0 {
            case .automatedEnrollment:
                return "1"
            case .manualActivation:
                return "2"
            case .requestActivation:
                return "3"
            }
        }

        filters.materialType = contentFilters.contentType.map {
            switch $0 {
            case .course:
                return "course"
            case .eBook:
                return "ebook"
            case .questionBank:
                return "question"
            }
        }

        if let minAmount = contentFilters.minAmount, let maxAmount = contentFilters.maxAmount {
            filters.remained = [minAmount, maxAmount]
        }

        if let searchQuery = contentFilters.searchQuery {
            filters.search = [searchQuery]
        }

        if let sortBy = contentFilters.sortDate {
            switch sortBy {
            case .dateLatest:
                filters.sort = ["-created_at"]
            case .dateOldest:
                filters.sort = ["created_at"]
            }
        }
        if let sortBy = contentFilters.sortAmount {
            switch sortBy {
            case .amountLowest:
                filters.sort = ["remained"]
            case .amountHighest:
                filters.sort = ["-remained"]
            }
        }

        return filters
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
            searchEnrollments()
        }
    }
}

// MARK: Functions

extension EnrollmentViewModel {
    func onAppear() {
        getEnrollmentCourses()
        prepereSearchSubscriber()
    }

    func onSearchBarClicked() {
        displaySearchScreen()
    }
    
    func onSearchBarCloseClick() {
        
        DispatchQueue.main.async {
            self.displayEnrollmentScreen()
        }
    }
    
    func onFiltersClicked() {
        displayFiltersScreen()
    }
    
    func onThreeDotsOptionsClicked() {
        withOptionalAnimation {
            isEnrollmentOptionsViewPresented = true
        }
    }
    
    func getNewEnrollmentCourses() {
        getEnrollmentCourses(page: enrollmentCoursesList.nextPage)
    }

    func onDeclineOptionClicked() {
        withOptionalAnimation {
            isEnrollmentOptionsViewPresented = false
            isDeclineOptionsViewPresented = true
        }
    }
    
    func onSaveDeclineChangesClicked() {
        isDeclineOptionsViewPresented = false
        declineCourse(enrollmentId: selectedEnrollment.enrollmentId, paidAmount: declineDebitValue)
    }

    func onYesButtonClicked() {
        switch enrollmentOptions {
        case .details:
            break
        case .decline:
            break
        case .warning:
            break
        case .resolve:
            resolveEnrollment()
        case .deactivate:
            print("Deactivate")
        }
    }
  
    func handleOptionClicked(option: EnrollmentOptions) {
        switch option {
        case .details:
            goToEnrollmentDetails()
        case .decline:
            onDeclineOptionClicked()
        case .warning:
            print("warning")
        case .resolve:
            showDialog(option: .resolve)
        case .deactivate:
            showDialog(option: .deactivate)
        }
    }
}

// MARK: Call APIs

extension EnrollmentViewModel {
    func getEnrollmentCourses(page: Page) {
        guard enrollmentLoadingState != .loading else { return }
        do {
            if enrollmentCoursesList.isAtFirstPage || filtersApplied {
                enrollmentLoadingState = .loading
                enrollmentCoursesList.pageContent = .placeholder
            }
            
            let filters = prepareEnrollmentContentFilters(contentFilters: filterOptions)
            let params = GetEnrollment(filters: filters)
            
            try enrollmentUseCase.execute(params: params)
                .sink(receiveCompletion: handleEnrollmentCoursesCompletion, receiveValue: handleEnrollmentCoursesResult)
                .store(in: &cancellables)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func handleEnrollmentCoursesCompletion(completion: Subscribers.Completion<UseCaseError>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print("Error: \(error)")
            showErrorToast(error: error)
            enrollmentLoadingState = .failed
            enrollmentCoursesList.pageContent = []
        }
    }
    
    func handleEnrollmentCoursesResult(EnrollmentPage: DomainWrapper<EnrollmentResponseDomain>) {
        enrollmentLoadingState = .loaded

        if enrollmentCoursesList.isAtFirstPage {
            enrollmentCoursesList.pageContent = []
        }
        
        if EnrollmentPage.isSuccess, let enrollment = EnrollmentPage.data {
            if enrollmentCoursesList.isAtFirstPage {
                if enrollment.pagination.pageContent.count == 0 {
                    isShowEmptyView = true
                }
                enrollmentCoursesList = enrollment.pagination
            } else {
                enrollmentCoursesList = enrollmentCoursesList.withPaginationValues(of: enrollment.pagination)
                
                enrollmentCoursesList.pageContent.append(contentsOf: enrollment.pagination.pageContent)
            }
            
        } else {
            print(EnrollmentPage.message)
            showErrorToast(message: EnrollmentPage.message)
        }
    }
}

// MARK: Decline Course

extension EnrollmentViewModel {
    func declineCourse(enrollmentId: Int, paidAmount: String) {
        do {
            declineCourseLoadingState = .loading
            try enrollmentUseCase.declineCourse(enrollment: enrollmentId, paidAmount: paidAmount)
                .sink(receiveCompletion: handleDeclineCourseCompletion, receiveValue: handleDeclineCourseResult)
                .store(in: &cancellables)
            
        } catch {
            declineCourseLoadingState = .failed
            print(error.localizedDescription)
        }
    }
    
    func handleDeclineCourseCompletion(completion: Subscribers.Completion<UseCaseError>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print("Error: \(error)")
            showErrorToast(error: error)
            declineCourseLoadingState = .failed
        }
    }
    
    func handleDeclineCourseResult(result: DomainWrapper<DeclineCourse>) {
        declineCourseLoadingState = .loaded

        if result.isSuccess {
            showToast(message: FinanceStrings.successfullyConfirmed.localized)
            if searchEnrollmentsResults.isEmpty {
                getEnrollmentCourses()
            }else {
               searchEnrollments()
            }
        } else {
            print(result.message)
            showErrorToast(message: result.message)
        }
    }
}

extension EnrollmentViewModel {
    private func searchEnrollments() {
        do {
            searchLoadingState = .loading
            searchEnrollmentsResults = .placeholder
            
            let filter = EnrollmentContentFilter(enrollmentType: [], remained: [], materialType: [], search: [searchText], sort: [])
            let params = GetEnrollment(filters: filter)
            
            try enrollmentUseCase.execute(params: params)
                .sink(receiveCompletion: handleSearchEnrollmentsCompletion,
                      receiveValue: handleEnrollmentsSearch)
                .store(in: &cancellables)
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }

    func handleSearchEnrollmentsCompletion(completion: Subscribers.Completion<UseCaseError>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print("Error: \(error)")
            showErrorToast(error: error)
            searchLoadingState = .failed
            searchEnrollmentsResults = []
        }
    }
    
    func handleEnrollmentsSearch(searchResults: DomainWrapper<EnrollmentResponseDomain>) {
        searchLoadingState = .loaded
        
        guard searchResults.isSuccess, let searchResults = searchResults.data else {
            showErrorToast(message: "Error message\n\(searchResults.message)")
            searchEnrollmentsResults = []
            return
        }
        searchEnrollmentsResults = searchResults.enrollments.map { enrollment in
            SearchResult<Enrollment>(content: enrollment)
        }
    }
}
