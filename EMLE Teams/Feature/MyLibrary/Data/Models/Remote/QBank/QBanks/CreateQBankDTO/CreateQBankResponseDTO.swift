//
//  CreateQBankResponseDTO.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 16/09/2024.
//

import Foundation

// MARK: - DataClass
class CreateQBankResponseDTO: Codable {
    let id: Int
    let uuid, name, overview: String
    let image: String?
    let is_visible: Bool
    let price: Int
    let duration: Int
    let trial_duration, questions_count, students_count: Int
    let questions: [QuestionBankDTO]
}
