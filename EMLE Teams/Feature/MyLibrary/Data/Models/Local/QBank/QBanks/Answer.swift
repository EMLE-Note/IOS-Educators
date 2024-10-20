//
//  Answer.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 14/09/2024.
//

import Foundation
import EMLECore

struct Answer: Identifiable, Hashable {
    
    let id: UUID = UUID()
    
    var number: String = ""
    let name: String
    let explanation: String
    var isCorrect: Bool
    
    var state: AnswerState = .idle
}

extension Answer: Equatable {
    
    static func == (lhs: Answer, rhs: Answer) -> Bool {
        lhs.id == rhs.id
    }
}

extension Answer {
    
    static let placeholder: Answer = {
        Answer(name: "Answer text",
               explanation: "Answer explanation",
               isCorrect: false)
    }()
}

extension [Answer] {
    
    static let placeholder: [Answer] = {
        var placeholder: [Answer] = []
        
        for i in 0..<4 {
            placeholder.append(Answer(name: "Answer text",
                                      explanation: "Answer explanation",
                                      isCorrect: i == 0))
        }
        
        return placeholder
    }()
}
