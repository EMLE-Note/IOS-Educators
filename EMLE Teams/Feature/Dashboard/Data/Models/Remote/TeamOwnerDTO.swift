//
//  TeamOwnerDTO.swift
//  EMLE Teams
//
//  Created by iOSAYed on 22/09/2024.
//

import Foundation

class TeamOwnerDTO: Codable {
    let id: Int
    let type: String
    let type_id: Int
    let name, mobile_code, mobile: String
    let email: String?
    let image: String
    let country_id, city_id, app_version, learning_type: Int?
    let avater_id: Int?
    let status: Int
    let register_status: String
    let email_verified_at: String?
    let created_at, updated_at, full_mobile: String
}
