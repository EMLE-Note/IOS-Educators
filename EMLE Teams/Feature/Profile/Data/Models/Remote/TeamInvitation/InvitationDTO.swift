//
//  InvitationDTO.swift
//  EMLE Teams
//
//  Created by iOSAYed on 27/10/2024.
//

import Foundation

class InvitationDTO: Codable {
    let id: Int
    let team_name: String
    let invitation_status: Int
    let status: Int
    let is_instructor: Int
    let role: String
}
