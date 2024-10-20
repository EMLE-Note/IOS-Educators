//
//  ForgetPassword3UseCase.swift
//  EMLE Learners
//
//  Created by Abdelrhman Sultan on 29/04/2024.
//

import Foundation
import EMLECore

class ForgetPassword3UseCase {
    var repository: IRegistrationRepository
    
    init(repository: IRegistrationRepository) {
        self.repository = repository
    }
    
    func execute(with params: ForgetPassword3) throws -> DomainBoolPublisher {
        try repository.forgetPassword3(params: params)
            .toMainThread()
    }
}
