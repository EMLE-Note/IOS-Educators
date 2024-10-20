//
//  ConfirmTransactionViewModel.swift
//  EMLE Teams
//
//  Created by iOSAYed on 05/08/2024.
//

import Foundation
import EMLECore
import Combine

final class ConfirmTransactionViewModel: MainViewModel {

    let coordinator: ConfirmTransactionCoordinating
    init(coordinator: ConfirmTransactionCoordinating) {
        self.coordinator = coordinator
    }
    var isTabBarVisible: Bool { false }
    var cancellables = Set<AnyCancellable>()
    let currancyCode = SharedData.shared.currancy.code ?? ""
    
    @Published var transactionsRequestsLoadingState:LoadingState = .loaded
    @Published var transactionsRequestsList: [TransactionRequests] = []
    @Published var selectedImageURL: ImageUrl? = nil
    @Published var transactionActionType:TransactionActionType = .confirm
    @Published var TransactionActionsLoadingState: LoadingState = .loaded

    
    @Inject var transactionsrequestsUseCase:TransactionsRequestsUseCase
}

extension ConfirmTransactionViewModel {
    func onAppear() {
        getTransactionsRequests()
    }
    
    func didClickDecline(tranactionRequestId:Int) {
        transactionActionType = .delete
        transactionRequestAction(tranactionRequestId:tranactionRequestId)
    }
    
    func didClickConfirm(tranactionRequestId:Int) {
        transactionActionType = .confirm
        transactionRequestAction(tranactionRequestId:tranactionRequestId)
    }
    
}

//MARK: get Transactions requests
extension ConfirmTransactionViewModel {
    func getTransactionsRequests() {
        do {
            try transactionsrequestsUseCase.execute()
                .sink(receiveCompletion: handleSecretriesCompletion, receiveValue: handleTransactionsRequestsResult)
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
            transactionsRequestsLoadingState = .failed
        }
    }
    
    func handleTransactionsRequestsResult(transactionsRequests: DomainWrapper<[TransactionRequests]>) {
        transactionsRequestsLoadingState = .loaded

        if transactionsRequests.isSuccess, let transactionsRequestsList = transactionsRequests.data {
            self.transactionsRequestsList = transactionsRequestsList
        } else {
            print(transactionsRequests.message)
            showErrorToast(message: transactionsRequests.message)
        }
    }
}

//MARK: Confirm & Delete Tranactions Request
extension ConfirmTransactionViewModel {
    
    func transactionRequestAction(tranactionRequestId:Int) {
        do {
            TransactionActionsLoadingState = .loading
            switch transactionActionType {
            case .confirm:
                try transactionsrequestsUseCase.confirmTransaction(transactionId: tranactionRequestId)
                    .sink(receiveCompletion: handleTransactionActionsCompletion, receiveValue: handleTransactionActionsResult)
                    .store(in: &cancellables)
            case .delete:
                
                try transactionsrequestsUseCase.deleteTransaction(transactionId: tranactionRequestId)
                    .sink(receiveCompletion: handleTransactionActionsCompletion, receiveValue: handleTransactionActionsResult)
                    .store(in: &cancellables)
            }
            
        } catch {
            TransactionActionsLoadingState = .failed
            print(error.localizedDescription)
        }
    }
    
    func handleTransactionActionsCompletion(completion: Subscribers.Completion<UseCaseError>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print("Error: \(error)")
            showErrorToast(error: error)
            TransactionActionsLoadingState  = .failed
        }
    }
    
    func handleTransactionActionsResult(transactionsRequests: DomainWrapper<TransactionDeleteConfirmModel>) {
        TransactionActionsLoadingState = .loaded

        if transactionsRequests.isSuccess {
            switch transactionActionType {
            case .confirm:
                showToast(message: FinanceStrings.successfullyConfirmed.localized)
                getTransactionsRequests()
            case .delete:
                showToast(message: FinanceStrings.successfullyConfirmed.localized)
                getTransactionsRequests()
            }
        } else {
            print(transactionsRequests.message)
            showErrorToast(message: transactionsRequests.message)
        }
    }
}
