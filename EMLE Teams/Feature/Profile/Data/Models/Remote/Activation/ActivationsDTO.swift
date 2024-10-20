//
//  ActivationsDTO.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 12/10/2024.
//

import Foundation

class ActivationsDTO: Codable {
    let id: Int
    let type: String
    let registration_id: Int
    let registration_name: String
    let paid_amount: Int
    let student: StudentDTO
    let requestable: RequestableDTO
    let created_at: String
}
