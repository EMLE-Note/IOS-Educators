//
//  UpdateQBankSettingResponseDTO.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 25/09/2024.
//

import Foundation

class UpdateQBankSettingResponseDTO: Codable {
    let id: Int
    let uuid, name, overview: String
    let image: String?
    let is_visible: Bool
    let price: Double
    let duration, trial_duration, questions_count: Int
    let students_count: Int
    
    init(id: Int, uuid: String, name: String, overview: String, image: String?, is_visible: Bool, price: Double, duration: Int, trial_duration: Int, questions_count: Int, students_count: Int) {
        self.id = id
        self.uuid = uuid
        self.name = name
        self.overview = overview
        self.image = image
        self.is_visible = is_visible
        self.price = price
        self.duration = duration
        self.trial_duration = trial_duration
        self.questions_count = questions_count
        self.students_count = students_count
    }
}
