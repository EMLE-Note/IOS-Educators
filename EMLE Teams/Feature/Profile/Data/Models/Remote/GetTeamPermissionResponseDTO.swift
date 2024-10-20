//
//  GetTeamPermissionResponseDTO.swift
//  EMLE Teams
//
//  Created by iOSAYed on 07/09/2024.
//

import Foundation

class GetTeamPermissionResponseDTO:Codable {
    let permissions: PermissionsDTO
    let roles: [String]
}
