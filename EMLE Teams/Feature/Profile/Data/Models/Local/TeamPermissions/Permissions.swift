//
//  MemberPermission.swift
//  EMLE Teams
//
//  Created by iOSAYed on 07/09/2024.
//

import Foundation

struct Permissions: Codable {
    let contents, enrollments: PermissionContent
    let finances, managements: [PermissionItem]
}

extension Permissions {
    static let placeholder = Permissions(contents: .placeholder, enrollments: .placeholder, finances: [.placeholder], managements: [.placeholder])
}



