//
//  GetActivationsUseCase.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 12/10/2024.
//

import Foundation

class GetActivationsUseCase {
    let repository: IProfileRepository
    
    init(repository: IProfileRepository) {
        self.repository = repository
    }
    
    func execute() throws -> ActivationPublisher {
        try repository.getActivationsData()
            .toMainThread()
    }
}
