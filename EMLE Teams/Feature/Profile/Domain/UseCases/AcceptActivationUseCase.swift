//
//  AcceptActivationUseCase.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 13/10/2024.
//

import Foundation

class AcceptActivationUseCase {
    let repository: IProfileRepository
    
    init(repository: IProfileRepository) {
        self.repository = repository
    }
    
    func execute(activationID: Int) throws -> AcceptActivationPublisher {
        try repository.acceptActivationsData(activationID: activationID)
            .toMainThread()
    }
}
