//
//  PermissionItem.swift
//  EMLE Teams
//
//  Created by iOSAYed on 07/09/2024.
//

import Foundation

struct PermissionItem: Codable {
    let id: Int
    let name: String
}

extension PermissionItem {
    static let placeholder = PermissionItem(id: 0, name: "edit")
}
