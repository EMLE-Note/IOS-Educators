//
//  QuestionDTO.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 19/08/2024.
//

import Foundation

// MARK: - Question
class QuestionDTO: Codable {
    let question: String
    let description: String?
    let type, correct_answer: String
    let answers, explanations: [String]
    let audio: String?
    let reference: String

}
