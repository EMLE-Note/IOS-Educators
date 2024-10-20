//
//  CreateQBankUseCase.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 17/09/2024.
//

import Foundation

class CreateQBankUseCase {
    private let repository: QBankRepositoryProtocol
    
    init(repository: QBankRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(params: CreateQBank) throws -> CreateQBankPublisher {
        try repository.createQBanks(params: params)
            .toMainThread()
    }
}
