//
//  AnswerFromRequestDTO.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 16/09/2024.
//

import Foundation
import EMLECore

class AnswerFromRequestDTO: Codable {
    var name: String?
    var explanation: String?
    
    func formData(questionIndex: Int, answerIndex: Int) -> FormData {
        var data: FormData = [:]

        if let name = name {
            data["questions[\(questionIndex)][answers][\(answerIndex)][name]"] = name
        }
        if let explanation = explanation {
            data["questions[\(questionIndex)][answers][\(answerIndex)][explanation]"] = explanation
        }
        return data
    }
    
    init(name: String?, explanation: String?) {
        self.name = name
        self.explanation = explanation
    }
}
