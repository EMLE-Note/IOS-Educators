//
//  CreateQBankFromRequestDTO.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 16/09/2024.
//

import Foundation
import EMLECore

class CreateQBankFromRequestDTO:  Codable {
    var name: String? = nil
    var uuid: String? = nil
    var image: Data? = nil
    var price: Double? = nil
    var duration: Int? = nil
    var is_visible: Int? = nil
    var overview: String? = nil
    var reference_id: Int? = nil
    var trial_duration: Int? = nil
    var questions: [QuestionBankQuestionFromRequestDTO]?

    // Custom initializer
    init(name: String? = nil,
         uuid: String? = nil,
         image: Data? = nil,
         price: Double? = nil,
         duration: Int? = nil,
         is_visible: Int? = nil,
         overview: String? = nil,
         reference_id: Int? = nil,
         trial_duration: Int? = nil,
         questions: [QuestionBankQuestionFromRequestDTO]? = nil) {
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

    // Form data generation
    var formData: FormData {
        var data: FormData = [:]

        if let name = name {
            data["name"] = name
        }
        if let uuid = uuid {
            data["uuid"] = uuid
        }
        if let image = image {
            data["image"] = image
        }
        if let price = price {
            data["price"] = price
        }
        if let duration = duration {
            data["duration"] = duration
        }
        if let is_visible = is_visible {
            data["is_visible"] = is_visible
        }
        if let overview = overview {
            data["overview"] = overview
        }
        if let reference_id = reference_id {
            data["reference_id"] = reference_id
        }
        if let trial_duration = trial_duration {
            data["trial_duration"] = trial_duration
        }
        if let questions = questions {
            for (index, question) in questions.enumerated() {
                let questionData = question.formData(index: index)
                for (key, value) in questionData {
                    data[key] = value
                }
            }
        }
        return data
    }
}
