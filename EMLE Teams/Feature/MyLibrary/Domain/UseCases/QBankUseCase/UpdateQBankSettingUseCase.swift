//
//  UpdateQBankSettingUseCase.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 26/09/2024.
//

import Foundation

class UpdateQBankSettingUseCase {
    private let repository: QBankRepositoryProtocol
    
    init(repository: QBankRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(params: UpdateQBankSettingParameter) throws -> UpdateQBankSettingPublisher {
        try repository.updateQBankSetting(params: params)
            .toMainThread()
    }
}
