//
//  QuestionBankQuestionDTO.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 16/09/2024.
//

import Foundation
import EMLECore

class QuestionBankQuestionFromRequestDTO: Codable {
    var name: String?
    var description: String?
    var answers: [AnswerFromRequestDTO]?
    var correct_answer: String?
    var explanations: [String]?
    var reference_syllabus_id: Int?
    var previous_exams: [Int]?
    var sources: [SourceDTO]?

    func formData(index: Int) -> FormData {
        var data: FormData = [:]

        if let name = name {
            data["questions[\(index)][name]"] = name
        }
        if let description = description {
            data["questions[\(index)][description]"] = description
        }
        if let answers = answers {
            for (answerIndex, answer) in answers.enumerated() {
                let answerData = answer.formData(questionIndex: index, answerIndex: answerIndex)
                for (key, value) in answerData {
                    data[key] = value
                }
            }
        }
        if let correct_answer = correct_answer {
            data["questions[\(index)][correct_answer]"] = correct_answer
        }
        if let reference_syllabus_id = reference_syllabus_id {
            data["questions[\(index)][reference_syllabus_id]"] = reference_syllabus_id
        }
        if let previous_exams = previous_exams {
            for (examIndex, exam) in previous_exams.enumerated() {
                data["questions[\(index)][previous_exams][\(examIndex)]"] = exam
            }
        }
        if let sources = sources {
            for (sourceIndex, source) in sources.enumerated() {
                let sourceData = source.formData(sourceIndex: sourceIndex, questionIndex: index)
                for (key, value) in sourceData {
                    data[key] = value
                }
            }
        }
        return data
    }
    
    init(name: String?, description: String?, answers: [AnswerFromRequestDTO]?, correct_answer: String?, explanations: [String]?, reference_syllabus_id: Int?, previous_exams: [Int]?, sources: [SourceDTO]?) {
        self.name = name
        self.description = description
        self.answers = answers
        self.correct_answer = correct_answer
        self.explanations = explanations
        self.reference_syllabus_id = reference_syllabus_id
        self.previous_exams = previous_exams
        self.sources = sources
    }
}
