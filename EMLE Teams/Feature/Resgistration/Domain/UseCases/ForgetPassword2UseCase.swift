//
//  ForgetPassword2UseCase.swift
//  EMLE Learners
//
//  Created by Abdelrhman Sultan on 28/04/2024.
//

import Foundation
import EMLECore

class ForgetPassword2UseCase {
    var repository: IRegistrationRepository
    
    init(repository: IRegistrationRepository) {
        self.repository = repository
    }
    
    func execute(with params: ForgetPassword2) throws -> DomainBoolPublisher {
        try repository.forgetPassword2(params: params)
            .toMainThread()
    }
}
