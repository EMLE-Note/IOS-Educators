//
//  QuestionBankDTO.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 16/09/2024.
//

import Foundation

// MARK: - Question
class QuestionBankDTO: Codable {
    let id: Int
    let name: String
    let description: String
    let correct_answer, sort: Int
    let answers: [AnswerDTO]
    let previous_exams: [PreviousExamDTO]
    let reference_syllabus: ReferenceSyllabusDTO
}
