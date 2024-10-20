//
//  TeamPermissions.swift
//  EMLE Teams
//
//  Created by iOSAYed on 07/09/2024.
//

import Foundation

struct TeamPermissions: Codable {
    let permissions: Permissions
    let roles: [String]
}

extension TeamPermissions {
    static let placeholder = TeamPermissions(permissions: .placeholder, roles: [])
}
