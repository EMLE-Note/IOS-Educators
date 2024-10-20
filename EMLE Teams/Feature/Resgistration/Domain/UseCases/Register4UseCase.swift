//
//  Register4UseCase.swift
//  EMLE Learners
//
//  Created by Abdelrhman Sultan on 25/04/2024.
//

import Foundation

class Register4UseCase {
    var repository: IRegistrationRepository
    
    init(repository: IRegistrationRepository) {
        self.repository = repository
    }
    
    func execute(with params: Register4) throws -> Register4Publisher {
        try repository.register4(params: params)
            .toMainThread()
    }
}
