//
//  CreateEnrollmentEBookUseCase.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 17/10/2024.
//

import Foundation

class CreateEnrollmentEBookUseCase {
    let repository: IProfileRepository
    
    init(repository: IProfileRepository) {
        self.repository = repository
    }
    
    func execute(parms: EnrollmentCourse) throws -> EnrollmentManualPublisher {
        try repository.createEnrollmentEBook(parms: parms)
            .toMainThread()
    }
}
