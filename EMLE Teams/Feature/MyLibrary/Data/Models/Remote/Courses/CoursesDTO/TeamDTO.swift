//
//  TeamDTO.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 21/08/2024.
//

import Foundation

// MARK: - Team
class TeamDTO: Codable {
    let id: Int
    let name, type: String
    let about: String?
    let situation: Int?
    let has_current_deal: Bool?
    let image: String?
    let owner: OwnerDTO
    let created_at, updated_at: String
}
