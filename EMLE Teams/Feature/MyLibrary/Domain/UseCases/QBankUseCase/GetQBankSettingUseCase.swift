//
//  GetQBankSettingUseCase.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 25/09/2024.
//

import Foundation

class GetQBankSettingUseCase {
    private let repository: QBankRepositoryProtocol
    
    init(repository: QBankRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(params: GetQBankSettingParameter) throws -> GetQBankSettingPublisher {
        try repository.getQBankSetting(params: params)
            .toMainThread()
    }
}
