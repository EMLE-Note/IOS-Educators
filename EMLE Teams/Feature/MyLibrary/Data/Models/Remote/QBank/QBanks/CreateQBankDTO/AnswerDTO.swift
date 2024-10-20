//
//  AnswerDTO.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 17/09/2024.
//

import Foundation

class AnswerDTO: Codable {
    var number: String
    var name: String
    var explanation: String
    var isCorrect: Bool
    
    init(number: String, name: String, explanation: String, isCorrect: Bool) {
        self.number = number
        self.name = name
        self.explanation = explanation
        self.isCorrect = isCorrect
    }
}

