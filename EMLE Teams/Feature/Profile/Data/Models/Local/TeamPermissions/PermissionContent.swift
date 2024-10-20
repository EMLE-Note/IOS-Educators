//
//  PermissionContent.swift
//  EMLE Teams
//
//  Created by iOSAYed on 07/09/2024.
//

import Foundation

struct PermissionContent: Codable {
    let courses, ebooks, quizzes: [PermissionItem]
}

extension PermissionContent {
    static let placeholder = PermissionContent(courses: [.placeholder], ebooks: [.placeholder], quizzes: [.placeholder])
}
