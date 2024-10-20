//
//  CreateQBankResponse.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 16/09/2024.
//

import Foundation
import EMLECore

struct CreateQBankResponse {
    let id: Int
    let uuid, name, overview: String
    let image: ImageUrl?
    let isVisible: Bool
    let price: Int
    let duration: Int
    let trialDuration, questionsCount, studentsCount: Int
    let questions: [QuestionBank]
}

// MARK: - Question
struct QuestionBank {
    let id: Int
    let name: String
    let description: String
    let correctAnswer, sort: Int
    let answers: [Answer]
    let previousExams: [PreviousExam]
    let referenceSyllabus: ReferenceSyllabus
}



