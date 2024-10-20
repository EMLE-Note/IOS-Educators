//
//  MemberDTO.swift
//  EMLE Teams
//
//  Created by iOSAYed on 20/09/2024.
//

import Foundation

class MemberDTO: Codable {
    let id: Int
    let name: String
    let image: String?
    let mobile_code, mobile, role: String
    let is_instructor, status, invitation_status: Int
    let team: String
    let team_id: Int
    let created_at, updated_at: String
//    let permissions: [Permissions]
}
