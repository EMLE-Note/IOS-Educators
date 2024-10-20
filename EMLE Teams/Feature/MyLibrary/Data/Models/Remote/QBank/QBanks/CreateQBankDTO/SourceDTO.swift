//
//  SourceDTO.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 28/09/2024.
//

import Foundation
import EMLECore

class SourceDTO: Codable {
    let name: String?
    let number: Int?

    func formData(sourceIndex: Int, questionIndex: Int) -> FormData {
        var data: FormData = [:]
        if let name = name {
            data["questions[\(questionIndex)][sources][\(sourceIndex)][name]"] = name
        }
        if let number = number {
            data["questions[\(questionIndex)][sources][\(sourceIndex)][number]"] = number
        }
        return data
    }

    init(name: String?, number: Int?) {
        self.name = name
        self.number = number
    }
}
