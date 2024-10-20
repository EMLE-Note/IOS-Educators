//
//  LoginUseCase.swift
//  EMLE Learners
//
//  Created by Abdelrhman Sultan on 04/04/2024.
//

import Foundation

class LoginUseCase {
    
    var repository: IRegistrationRepository
    
    init(repository: IRegistrationRepository) {
        self.repository = repository
    }
    
    func execute(with params: Login) throws -> LoginPublisher {
        try repository.login(params: params)
            .toMainThread()
    }
}
