//
//  TransactionsRequestsUseCase.swift
//  EMLE Teams
//
//  Created by iOSAYed on 06/08/2024.
//

import Foundation
import EMLECore

class TransactionsRequestsUseCase {
    private let repository: FinanceRepositoryProtocol
    
    init(repository: FinanceRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() throws -> GetTransactionsRequestsDataPublisher {
        try repository.getTransactionsRequests()
            .toMainThread()
    }
    
    func confirmTransaction(transactionId: Int) throws -> ConfirmTransactionsRequestsDataPublisher {
           try repository.confirmTransaction(transactionId: transactionId)
               .toMainThread()
       }

       func deleteTransaction(transactionId: Int) throws -> ConfirmTransactionsRequestsDataPublisher {
           try repository.deleteTransaction(transactionId: transactionId)
               .toMainThread()
       }
}
