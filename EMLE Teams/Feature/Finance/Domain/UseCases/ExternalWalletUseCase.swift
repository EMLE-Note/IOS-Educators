//
//  ExternalWalletUseCase.swift
//  EMLE Teams
//
//  Created by iOSAYed on 21/07/2024.
//

import Foundation

class ExternalWalletUseCase {
    private let repository: FinanceRepositoryProtocol
    
    init(repository: FinanceRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(params:GetExternalWallet) throws -> GetExternalWalletDataPublisher {
        try repository.getExternalWallet(params: params)
            .toMainThread()
    }
}
