//
//  UpdateQBankSettingResponse.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 25/09/2024.
//

import Foundation

struct UpdateQBankSettingResponse {
    let id: Int
    let uuid, name, overview: String
    let image: String
    let isVisible: Bool
    let price: Double
    let duration, trialDuration, questionsCount: Int
    let studentsCount: Int
}
