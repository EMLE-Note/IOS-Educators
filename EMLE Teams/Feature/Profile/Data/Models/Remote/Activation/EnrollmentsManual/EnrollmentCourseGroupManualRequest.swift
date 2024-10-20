//
//  EnrollmentCourseGroupManualRequest.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 20/10/2024.
//

import Foundation
import EMLECore

class EnrollmentCourseGroupManualRequest: CustomRequest {
    
    var endPoint: APIEndPoint { .enrollmentMass }
    
    var url: String { String(format: MainCloudConfig.apiUrl + endPoint.value) }
    
    var method: RequestMethod { .post }
    
    var dto: RequestDTO? { _dto }

    private let _dto: EnrollmentCourseGroupDTO
    
    init(data: [EnrollmentMassCourse]) {
        self._dto = EnrollmentCourseGroupDTO(data: data.compactMap({ data in
            EnrollmentMassCourseDTO(course_id: data.courseId, student_id: data.studentId, paid_amount: data.paidAmount, price: data.price)
        }))
    }
}
