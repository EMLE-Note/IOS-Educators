//
//  EnrollmentResponseDTO.swift
//  EMLE Teams
//
//  Created by iOSAYed on 11/08/2024.
//

import Foundation
class EnrollmentResponseDTO: Codable {
    let id, status, type: Int
    let  price, remained: Double
    let content: EnrollmentContentDTO
    let student: StudentDTO
    let expire_at: String?
    let created_at: String
}