//
//  FinanceUseCase.swift
//  EMLE Teams
//
//  Created by iOSAYed on 03/07/2024.
//

import Foundation

class FinanceDataUseCase {
    private let repository: FinanceRepositoryProtocol
    
    init(repository: FinanceRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() throws -> FinanceDataPublisher {
        try repository.getFinanceData()
            .toMainThread()
    }
}
