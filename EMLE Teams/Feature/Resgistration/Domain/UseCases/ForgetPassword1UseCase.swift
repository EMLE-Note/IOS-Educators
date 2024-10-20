//
//  ForgetPassword1UseCase.swift
//  EMLE Learners
//
//  Created by Abdelrhman Sultan on 28/04/2024.
//

import Foundation

class ForgetPassword1UseCase {
    var repository: IRegistrationRepository
    
    init(repository: IRegistrationRepository) {
        self.repository = repository
    }
    
    func execute(with params: ForgetPassword1) throws -> forgetPassword1Publisher {
        try repository.forgetPassword1(params: params)
            .toMainThread()
    }
}
