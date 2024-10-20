//
//  Register1UseCase.swift
//  EMLE Learners
//
//  Created by Abdelrhman Sultan on 15/04/2024.
//

import Foundation

class Register1UseCase {
    
    var repository: IRegistrationRepository
    
    init(repository: IRegistrationRepository) {
        self.repository = repository
    }
    
    func execute(with params: Register1) throws -> Register1Publisher {
        try repository.register1(params: params)
            .toMainThread()
    }
}
