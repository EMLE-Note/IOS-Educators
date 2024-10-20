//
//  ExcelQuestionBankResult.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 16/09/2024.
//

import Foundation
import EMLECore

struct ExcelQuestionBankResult {
    var msg: String
    var fileName: String
    var list: [QuestionBankQuestionModel]
}

struct QuestionBankQuestionModel: Identifiable {
    let id: Int
    var name: String
    var description: String
    var answers: [Answer]
    var correct_answer: String
    var explanations: [String]
    var reference_syllabus_id: Int
    var reference_syllabus: ReferenceSyllabus?
    var previous_exam_id: [Int]
    var source: [Source]
}
