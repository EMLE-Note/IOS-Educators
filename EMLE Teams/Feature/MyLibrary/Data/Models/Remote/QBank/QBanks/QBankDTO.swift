//
//  QBankDTO.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 02/09/2024.
//

import Foundation

// MARK: - Qbank
class QBankDTO: Codable {
    let id: Int
    let uuid, name, overview: String
    let image: String?
    let is_visible: Bool
    let price: Int?
    var duration: Int?
    let trial_duration, questions_count: Int
    let students_count: Int?
    let currency: String?
}
