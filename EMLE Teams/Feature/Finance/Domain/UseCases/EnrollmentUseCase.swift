//
//  EnrollmentUseCase.swift
//  EMLE Teams
//
//  Created by iOSAYed on 11/08/2024.
//

import Foundation

class EnrollmentUseCase {
    private let repository: FinanceRepositoryProtocol
    
    init(repository: FinanceRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(params:GetEnrollment) throws -> GetEnrollmentCoursesDataPublisher {
        try repository.getEnrollmentCourses(params: params)
            .toMainThread()
    }
    
    func declineCourse(enrollment: Int,paidAmount:String) throws -> PostDeclineCourseDataPublisher {
        try repository.declineCourse(enrollmentId: enrollment, paidAmount: paidAmount)
               .toMainThread()
       }
}
