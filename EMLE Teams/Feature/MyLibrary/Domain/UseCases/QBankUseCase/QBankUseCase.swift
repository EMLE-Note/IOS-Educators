//
//  QBankUseCase.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 02/09/2024.
//

import Foundation

class QBankUseCase {
    private let repository: QBankRepositoryProtocol
    
    init(repository: QBankRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(params: GetQBank) throws -> GetQBankPublisher {
        try repository.getQBanks(params: params)
            .toMainThread()
    }
}
