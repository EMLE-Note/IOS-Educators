//
//  SearchViewModel.swift
//  EMLE Teams
//
//  Created by iOSAYed on 14/08/2024.
//

import Foundation
import EMLECore
import Combine

typealias SearchResultDelegate<T> = GenericAction<SearchResult<T>>

final class SearchViewModel: MainViewModel {
    
    @Published var searchText: String = "" {
        willSet {
            if newValue != searchText && !newValue.isEmpty {
                searchLoadingState = .loading
                
                switch searchContentType {
                case .transactions:
                      searchTransactionsResults = .placeholder
                case .enrollments:
                    searchEnrollmentsResults = .placeholder
                }
            }
        }
    }
    
   
    
    @Published var searchTransactionsResults: [SearchResult<ExternalWallet>] = []
    @Published var searchEnrollmentsResults: [SearchResult<Enrollment>] = []
    @Published var declineDebitValue: String = ""
    @Published var isEnrollmentOptionsViewPresented: Bool = false
    @Published var isDialogPresent: Bool = false
    @Published var isDeclineOptionsViewPresented: Bool = false

    @Inject var transactionsUseCase: ExternalWalletUseCase
    @Inject var enrollmentsUseCase: EnrollmentUseCase
    
    
    @Published var searchLoadingState: LoadingState = .loaded
    
    private var closeAction: EmptyAction
    private var coordinator: SearchViewCoordinating
    private var cancellables = Set<AnyCancellable>()
    
    var searchContentType: SearchContentType
    var isTabBarVisible: Bool {false}

    init(searchContentType: SearchContentType, closeAction: EmptyAction, coordinator: SearchViewCoordinating) {
        self.searchContentType = searchContentType
        self.closeAction = closeAction
        self.coordinator = coordinator
    }
    
}
extension SearchViewModel {
    func onAppear() {
        if searchEnrollmentsResults.isEmpty && searchTransactionsResults.isEmpty {
            addSearchSubscriber()
        }
    }
    
    func onSearchBarCloseClick() {
        closeAction?()
    }
    
    func goToEnrollmentDetails(enrollment:Enrollment) {
        coordinator.goToEnrollmentDetails(enrollment: enrollment)
    }
    
    func goToTransactionDetails(transaction:ExternalWallet) {
        coordinator.goToTransactionDetails(transaction: transaction)
    }
}


extension SearchViewModel {
    
    private func addSearchSubscriber() {
        $searchText
            .removeDuplicates()
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .sink { [weak self] text in
                self?.searchForResults()
            }
            .store(in: &cancellables)
    }
    
    private func searchForResults() {
        if !searchText.isEmpty {
            
            print("searchForResults for \(searchText) in \(searchContentType)")
            
            searchContent(contentType: searchContentType)
        }
    }
    
    private func searchContent(contentType: SearchContentType) {
        
        switch contentType {
        case .transactions:
            searchTransactions()
        case .enrollments:
            searchEnrollments()
            break
        }
    }
    
    private func searchTransactions() {
        do {
            searchLoadingState = .loading
            searchTransactionsResults = .placeholder
            
            let filter = TransactionsContentFilter(enrollmentType: [], contentType: [], amount: [], search: [searchText], teamStaffId: [], sort: [])
            let params = GetExternalWallet(filters: filter)
            
            try transactionsUseCase.execute(params: params)
                .sink(receiveCompletion: handleSearchCoursesCompletion,
                      receiveValue: handleTransactionsSearch)
                .store(in: &cancellables)
        }
        catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func handleSearchCoursesCompletion(completion: Subscribers.Completion<UseCaseError>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print("Error: \(error)")
            showErrorToast(error: error)
            searchLoadingState = .failed
            self.searchTransactionsResults = []
        }
    }
    
    func handleTransactionsSearch(searchResults: DomainWrapper<ExternalWalletResponseDomain>) {
        searchLoadingState = .loaded
        
        guard searchResults.isSuccess, let searchResults = searchResults.data else {
            showErrorToast(message: "Error message\n\(searchResults.message)")
            self.searchTransactionsResults = []
            return
        }
           self.searchTransactionsResults = searchResults.externalWallets.map { externalWallet in
               SearchResult<ExternalWallet>(content: externalWallet)
           }
    }
}

extension SearchViewModel {
    private func searchEnrollments() {
        do {
            searchLoadingState = .loading
            searchEnrollmentsResults = .placeholder
            
            let filter = EnrollmentContentFilter(enrollmentType: [], remained: [], materialType: [], search: [searchText], sort: [])
            let params = GetEnrollment(filters:filter)
            
            try enrollmentsUseCase.execute(params: params)
                .sink(receiveCompletion: handleSearchCoursesCompletion,
                      receiveValue: handleEnrollmentsSearch)
                .store(in: &cancellables)
        }
        catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func handleEnrollmentsSearch(searchResults: DomainWrapper<EnrollmentResponseDomain>) {
        searchLoadingState = .loaded
        
        guard searchResults.isSuccess, let searchResults = searchResults.data else {
            showErrorToast(message: "Error message\n\(searchResults.message)")
            self.searchEnrollmentsResults = []
            return
        }
           self.searchEnrollmentsResults = searchResults.enrollments.map { enrollment in
               SearchResult<Enrollment>(content: enrollment)
           }
    }
}
