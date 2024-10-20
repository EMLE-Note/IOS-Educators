//
//  EnrollmentCourseManualRequest.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 17/10/2024.
//

import Foundation
import EMLECore

class EnrollmentCourseManualRequest: CustomRequest {
    
    var endPoint: APIEndPoint { .enrollmentCourse }
    
    var url: String { String(format: MainCloudConfig.apiUrl + endPoint.value) }
    
    var method: RequestMethod { .post }
    
    var dto: RequestDTO? { _dto }

    private let _dto: EnrollmentCourseDTO
    
    init(dto: EnrollmentCourse) {
        self._dto = EnrollmentCourseDTO(
            student_id: dto.studentId,
            course_id: dto.courseId,
            paid_amount: dto.paidAmount,
            location_id: dto.locationId,
            notes: dto.notes,
            price: dto.price
        )
    }
}
