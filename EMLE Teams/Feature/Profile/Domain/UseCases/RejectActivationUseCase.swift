//
//  RejectActivationUseCase.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 13/10/2024.
//

import Foundation

class RejectActivationUseCase {
    let repository: IProfileRepository
    
    init(repository: IProfileRepository) {
        self.repository = repository
    }
    
    func execute(activationID: Int) throws -> RejectActivationPublisher {
        try repository.rejectActivationsData(activationID: activationID)
            .toMainThread()
    }
}
