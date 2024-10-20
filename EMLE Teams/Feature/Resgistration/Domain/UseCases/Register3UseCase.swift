//
//  Register3UseCase.swift
//  EMLE Learners
//
//  Created by Abdelrhman Sultan on 20/04/2024.
//

import Foundation

class Register3UseCase {
    var repository: IRegistrationRepository
    
    init(repository: IRegistrationRepository) {
        self.repository = repository
    }
    
    func execute(with params: Register3) throws -> Register3Publisher {
        try repository.register3(params: params)
            .toMainThread()
    }
}
