//
//  PermissionContentDTO.swift
//  EMLE Teams
//
//  Created by iOSAYed on 07/09/2024.
//

import Foundation

class PermissionContentDTO: Codable {
    let courses, ebooks, quizzes: [PermissionItemDTO]
}
