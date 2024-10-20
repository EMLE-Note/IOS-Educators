//
//  CreateQBank.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 16/09/2024.
//

import Foundation

struct CreateQBank {
    let name: String
    let uuid: String
    var image: Data?
    let price: Double
    let duration: Int?
    let isVisible: Int
    let overview: String
    let referenceId: Int
    let trialDuration: Int?
    let questions: [QuestionBankQuestionModel]?
}

extension CreateQBank {
    static let empty = CreateQBank(
        name: "QBank",
        uuid: "",
        image: nil,
        price: 0.0,
        duration: 0,
        isVisible: 0,
        overview: "QBank Overview",
        referenceId: 0,
        trialDuration: 0,
        questions: []
    )
}
