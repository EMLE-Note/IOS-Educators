//
//  AnswerState.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 14/09/2024.
//

import Foundation

enum AnswerState {
    
    case idle
    case selected
    case correct
    case wrong
    
    var isCorrect: Bool { self == .correct }
    var isSelected: Bool { self == .selected }
    var isWrong: Bool { self == .wrong }
}
