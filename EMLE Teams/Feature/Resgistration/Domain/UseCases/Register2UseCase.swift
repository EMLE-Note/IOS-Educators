//
//  Register2UseCase.swift
//  EMLE Learners
//
//  Created by Abdelrhman Sultan on 16/04/2024.
//

import Foundation

class Register2UseCase {
    var repository: IRegistrationRepository
    
    init(repository: IRegistrationRepository) {
        self.repository = repository
    }
    
    func execute(with params: Register2) throws -> Register2Publisher {
        try repository.register2(params: params)
            .toMainThread()
    }
}
