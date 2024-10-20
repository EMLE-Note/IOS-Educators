//
//  CreateEnrollmentMassCourseUseCase.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 20/10/2024.
//

import Foundation

class CreateEnrollmentMassCourseUseCase {
    let repository: IProfileRepository
    
    init(repository: IProfileRepository) {
        self.repository = repository
    }
    
    func execute(parms: EnrollmentCourseParameter) throws -> EnrollmentManualPublisher {
        try repository.createEnrollmentMassCourse(parms: parms)
            .toMainThread()
    }
}
