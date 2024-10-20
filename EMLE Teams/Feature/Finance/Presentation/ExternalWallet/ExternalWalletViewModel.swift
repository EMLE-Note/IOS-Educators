//
//  ExternalWalletViewModel.swift
//  EMLE Teams
//
//  Created by iOSAYed on 18/07/2024.
//

import Combine
import EMLECore
import Foundation

final class ExternalWalletViewModel: MainViewModel {
    
    let coordinator: ExternalWalletCoordinating
    var searchViewCoordinator: SearchViewCoordinator
    init(coordinator: ExternalWalletCoordinating) {
        self.coordinator = coordinator
        self.searchViewCoordinator = SearchViewCoordinator(navigationController: coordinator.navigationController, tabBarController: coordinator.tabBarController)
    }
    
    var isTabBarVisible: Bool { false }
    var cancellables = Set<AnyCancellable>()
    let currancyCode = SharedData.shared.currancy.code ?? ""
    
    @Published var filterOptions: TransactionFilterOptions = .empty
    @Published var TransactionsData: PaginatedContent<[ExternalWallet]> = PaginatedContent([])
    @Published var transactionRequestCount: Int = 0
    @Published var secretariesList: [Secretary] = []
    @Published var searchExternalWalletResults: [SearchResult<ExternalWallet>] = []
    @Published var screenType: ScreenType = .content
    @Published var externalWalletLoadingState: LoadingState = .loaded
    @Published var secretaryLoadingState: LoadingState = .loaded
    @Published var searchLoadingState: LoadingState = .loaded
    @Published var isShowEmptyView: Bool = false
    @Published var selectedTransactionId: Int = -1
    
    @Published var searchText: String = "" {
        willSet {
            if newValue != searchText && !newValue.isEmpty {
                searchLoadingState = .loading
                searchExternalWalletResults = .placeholder
            }
        }
    }


    
    @Inject var externalWalletUseCase: ExternalWalletUseCase
    @Inject var secretayUseCase: SecretaryUseCase
    
    var enrollmentType: EnrollmentType = .Manual
    
    private var filtersApplied: Bool {
        return filterOptions.isSelected
    }
    
}

// MARK: Functions

extension ExternalWalletViewModel {
    func onAppear() {
        getInfo()
        prepereSearchSubscriber()
        
    }
    
    private func getInfo(){
        getTransactions()
        getSecretries()
    }
    
    func onClickedOnConfirmTransactions() {
        coordinator.goToConfirmTransactionView()
    }
    
    func onSelectedTransaction(transactionId: Int) {
        selectedTransactionId = transactionId
        prepareTransactionClicked()
    }
    
    private func prepareTransactionClicked(){
        filterOptions.teamStaffID = "\(selectedTransactionId)"
        isShowEmptyView = false
        TransactionsData = PaginatedContent([])
        getTransactions(page: TransactionsData.nextPage)
    }
    private func prepareSearchFilter() {
        print(searchText)
        isShowEmptyView = false
        filterOptions.searchQuery = searchText
    }
    
    func onFiltersClicked() {
        displayFiltersScreen()
    }
    
    func onSearchBarClicked() {
        displaySearchScreen()
    }
    func onSearchBarCloseClick() {
        displayExternalScreen()
    }
    
    func onClickedTransactionCard(transaction: ExternalWallet) {
        coordinator.goToTransactionDetails(transactionDetails: transaction)
    }
    
    private func resetPages() {
        TransactionsData.currentPage = 0
    }
    
    func getTransactions(){
        resetPages()
        getTransactions(page: TransactionsData.nextPage)
    }
    
    func getNewTransactions() {
        getTransactions(page: TransactionsData.nextPage)
    }
}

extension ExternalWalletViewModel {
    private func changeScreenType(to type: ScreenType) {
        withOptionalAnimation {
            screenType = type
        }
    }
    
    private func displayExternalScreen() {
        changeScreenType(to: .content)
    }
    
    private func displayFiltersScreen() {
        changeScreenType(to: .filters)
    }
    private func displaySearchScreen() {
        changeScreenType(to: .search)
    }
    
    func onFiltersClose() {
        displayExternalScreen()
        isShowEmptyView = false
        TransactionsData = PaginatedContent([])
        let filters = prepareTransactionsContentFilters(contentFilters: filterOptions)
        print(filters)
        getTransactions(page: TransactionsData.nextPage)
    }
    
    private func prepareTransactionsContentFilters(contentFilters: TransactionFilterOptions) -> TransactionsContentFilter {
        var filters: TransactionsContentFilter = .empty
        
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

        filters.contentType = contentFilters.contentType.map {
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
            filters.amount = [minAmount, maxAmount]
        }

        if let searchQuery = contentFilters.searchQuery {
            filters.search = [searchQuery]
        }

        if let teamStaffID = contentFilters.teamStaffID {
            filters.teamStaffId = [teamStaffID]
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
                filters.sort = ["amount"]
            case .amountHighest:
                filters.sort = ["-amount"]
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
        if searchExternalWalletResults.isEmpty, searchExternalWalletResults.isEmpty {
            addSearchSubscriber()
        }
    }
    
    private func searchForResults() {
        if !searchText.isEmpty {
            print("searchForResults for \(searchText) ")
            searchTransactions()
        }
    }
}

// MARK: APIs Call

extension ExternalWalletViewModel {
    func getTransactions(page: Page) {
        guard externalWalletLoadingState != .loading else { return }
       
        do {
            if TransactionsData.isAtFirstPage || filtersApplied {
                externalWalletLoadingState = .loading
                TransactionsData.pageContent = .placeholder
            }
            
            let filters = prepareTransactionsContentFilters(contentFilters: filterOptions)
            print(filters)
            let params = GetExternalWallet(filters: filters)
            
            try externalWalletUseCase.execute(params: params)
                .sink(receiveCompletion: handleTransactionsCompletion, receiveValue: handleTransactionsResult)
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
            externalWalletLoadingState = .failed
            TransactionsData.pageContent = []
        }
    }
    
    func handleTransactionsResult(ExternalWalletPage: DomainWrapper<ExternalWalletResponseDomain>) {
        externalWalletLoadingState = .loaded

        if TransactionsData.isAtFirstPage {
            TransactionsData.pageContent = []
        }
        
        if ExternalWalletPage.isSuccess, let walletPage = ExternalWalletPage.data {
            transactionRequestCount = walletPage.transactionRequestCount
            
            if TransactionsData.isAtFirstPage {
                if walletPage.pagination.pageContent.count == 0 {
                    isShowEmptyView = true
                }
                TransactionsData = walletPage.pagination
            } else {
                TransactionsData = TransactionsData.withPaginationValues(of: walletPage.pagination)
                
                TransactionsData.pageContent.append(contentsOf: walletPage.pagination.pageContent)
            }
            
        } else {
            print(ExternalWalletPage.message)
            showErrorToast(message: ExternalWalletPage.message)
        }
    }
}

// MARK: Get Secretaries

extension ExternalWalletViewModel {
    func getSecretries() {
        do {
            try secretayUseCase.execute()
                .sink(receiveCompletion: handleSecretriesCompletion, receiveValue: handleSecretriesResult)
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
            secretaryLoadingState = .failed
        }
    }
    
    func handleSecretriesResult(secretaries: DomainWrapper<[Secretary]>) {
        secretaryLoadingState = .loaded

        if secretaries.isSuccess, let secretariesList = secretaries.data {
            self.secretariesList = secretariesList
        } else {
            print(secretaries.message)
            showErrorToast(message: secretaries.message)
        }
    }
}

extension ExternalWalletViewModel {
    private func searchTransactions() {
        do {
            searchLoadingState = .loading
            searchExternalWalletResults = .placeholder
            
            let filter = TransactionsContentFilter(enrollmentType: [], contentType: [], amount: [], search: [searchText], teamStaffId: [], sort: [])
            let params = GetExternalWallet(filters: filter)
            
            try externalWalletUseCase.execute(params: params)
                .sink(receiveCompletion: handleSearchTransactionsCompletion,
                      receiveValue: handleTransactionsSearch)
                .store(in: &cancellables)
        }
        catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func handleSearchTransactionsCompletion(completion: Subscribers.Completion<UseCaseError>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print("Error: \(error)")
            showErrorToast(error: error)
            searchLoadingState = .failed
            self.searchExternalWalletResults = []
        }
    }
    
    func handleTransactionsSearch(searchResults: DomainWrapper<ExternalWalletResponseDomain>) {
        searchLoadingState = .loaded
        
        guard searchResults.isSuccess, let searchResults = searchResults.data else {
            showErrorToast(message: "Error message\n\(searchResults.message)")
            self.searchExternalWalletResults = []
            return
        }
           self.searchExternalWalletResults = searchResults.externalWallets.map { externalWallet in
               SearchResult<ExternalWallet>(content: externalWallet)
           }
    }
}
