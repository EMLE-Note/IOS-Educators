//
//  CreateTeamResponseDTO.swift
//  EMLE Teams
//
//  Created by iOSAYed on 22/09/2024.
//

import Foundation

class CreateTeamResponseDTO: Codable {
    let id: Int
    let name, type, about: String
    let image: String?
//    let owner: OwnerDTO
    let created_at, updated_at: String
}
