//
//  EnrollmentCourseGroupDTO.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 20/10/2024.
//

import Foundation
import EMLECore

class EnrollmentCourseGroupDTO: Codable, RequestDTO {
    var data: [EnrollmentMassCourseDTO]
    
    init(data: [EnrollmentMassCourseDTO]) {
        self.data = data
    }
}
