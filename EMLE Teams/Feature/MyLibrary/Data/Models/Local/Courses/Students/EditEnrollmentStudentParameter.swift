//
//  EditEnrollmentStudentParameter.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 26/08/2024.
//

import Foundation

struct UpdateEnrollmentStudentParameter {
    var enrollmentId: Int
    var status: Int?
    var security: Security?
    var method: String
    var locationId: Int?
    var expireAt: String?
}
