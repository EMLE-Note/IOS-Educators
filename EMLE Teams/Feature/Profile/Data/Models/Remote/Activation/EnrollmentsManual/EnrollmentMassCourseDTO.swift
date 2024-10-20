//
//  EnrollmentMassCourseDTO.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 20/10/2024.
//

import Foundation
import EMLECore

class EnrollmentMassCourseDTO: Codable, RequestDTO {
    let course_id: Int
    let student_id: Int
    let paid_amount: Int
    let price: Int
    
    init(course_id: Int, student_id: Int, paid_amount: Int, price: Int) {
        self.course_id = course_id
        self.student_id = student_id
        self.paid_amount = paid_amount
        self.price = price
    }

}
