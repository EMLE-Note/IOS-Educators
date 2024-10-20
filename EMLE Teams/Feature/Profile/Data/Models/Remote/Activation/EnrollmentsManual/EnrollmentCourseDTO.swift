//
//  EnrollmentCourseDTO.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 17/10/2024.
//

import Foundation
import EMLECore

class EnrollmentCourseDTO: Codable, RequestDTO {
    var student_id: Int?
    var course_id: Int?
    var paid_amount: Int?
    var location_id: Int?
    var notes: String?
    var price: Int?
    
    init(student_id: Int? = nil, course_id: Int? = nil, paid_amount: Int? = nil, location_id: Int? = nil, notes: String? = nil, price: Int? = nil) {
        self.student_id = student_id
        self.course_id = course_id
        self.paid_amount = paid_amount
        self.location_id = location_id
        self.notes = notes
        self.price = price
    }
}
