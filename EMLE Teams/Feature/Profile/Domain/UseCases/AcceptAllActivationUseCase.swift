//
//  AcceptAllActivationUseCase.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 14/10/2024.
//

import Foundation

class AcceptAllActivationUseCase {
    let repository: IProfileRepository
    
    init(repository: IProfileRepository) {
        self.repository = repository
    }
    
    func execute(activationID: [Int]) throws -> AcceptActivationPublisher {
        try repository.acceptAllActivationsData(activationID: activationID)
            .toMainThread()
    }
}
