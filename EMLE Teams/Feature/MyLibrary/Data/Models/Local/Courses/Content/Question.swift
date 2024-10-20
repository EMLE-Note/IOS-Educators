//
//  Question.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 19/08/2024.
//

import Foundation
// MARK: - Question
struct Question: Identifiable, Hashable {
    let id: UUID = UUID()
    let question: String
    let description: String?
    let type, correctAnswer: String
    let answers, explanations: [String]
    let audio: String?
    let reference: String
}

extension Question {
    
    static let placeholder: Question = {
        Question(
            question: "",
            description: "",
            type: "",
            correctAnswer: "",
            answers: [],
            explanations: [],
            audio: "",
            reference: ""
        )
    }()
}

extension [Question] {
    
    static let placeholder: [Question] = {
        var placeholder: [Question] = []
        
        for i in 0..<5 {
            placeholder.append(Question(
                question: "",
                description: "",
                type: "",
                correctAnswer: "",
                answers: [],
                explanations: [],
                audio: "",
                reference: ""
            ))
        }
        
        return placeholder
    }()
}
