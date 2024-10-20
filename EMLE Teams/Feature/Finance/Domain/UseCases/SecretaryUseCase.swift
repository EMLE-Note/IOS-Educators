//
//  SecretaryUseCase.swift
//  EMLE Teams
//
//  Created by iOSAYed on 24/07/2024.
//

import Foundation

class SecretaryUseCase {
    private let repository: FinanceRepositoryProtocol
    
    init(repository: FinanceRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() throws -> GetSecretaryDataPublisher {
        try repository.getSecretay()
            .toMainThread()
    }
}
