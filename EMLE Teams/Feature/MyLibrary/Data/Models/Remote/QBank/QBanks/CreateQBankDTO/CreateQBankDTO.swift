//
//  CreateQBankDTO.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 16/09/2024.
//

import Foundation
import EMLECore

class CreateQBankDTO: RequestDTO, Codable {
    var name: String
    var uuid: Int
    var image: Data?
    var price: Double
    var duration: Int
    var is_visible: Int
    var overview: String
    var reference_id: Int
    var trial_duration: Int? = nil
    var questions: [QuestionBankQuestionFromRequestDTO]? = nil

    // Custom initializer
    init(name: String, uuid: Int, image: Data? = nil, price: Double, duration: Int, is_visible: Int, overview: String, reference_id: Int, trial_duration: Int? = nil, questions: [QuestionBankQuestionFromRequestDTO]? = nil) {
        self.name = name
        self.uuid = uuid
        self.image = image
        self.price = price
        self.duration = duration
        self.is_visible = is_visible
        self.overview = overview
        self.reference_id = reference_id
        self.trial_duration = trial_duration
        self.questions = questions
    }
}
