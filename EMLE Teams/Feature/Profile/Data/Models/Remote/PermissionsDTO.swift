//
//  PermissionsDTO.swift
//  EMLE Teams
//
//  Created by iOSAYed on 07/09/2024.
//

import Foundation

class PermissionsDTO: Codable {
    let contents, enrollments: PermissionContentDTO
    let finances, managements: [PermissionItemDTO]
}
