//
//  EnrollmentStudentDTO.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 19/08/2024.
//

import Foundation

// MARK: - Enrollment
class EnrollmentStudentDTO: Codable {
    let id: Int
    let security: SecurityDTO?
    let status: Int
    let expire_at: String?
    let student: StudentDTO
    let location: String?
    let created_at: String?
}
