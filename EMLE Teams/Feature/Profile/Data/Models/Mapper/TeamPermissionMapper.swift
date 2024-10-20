//
//  TeamPermissionMapper.swift
//  EMLE Teams
//
//  Created by iOSAYed on 07/09/2024.
//

import Foundation


extension GetTeamPermissionResponseDTO {
    func toTeamPermissions() -> TeamPermissions {
        return  TeamPermissions(permissions: permissions.toDomain(), roles: roles)
    }
}

extension PermissionsDTO {
    func toDomain() -> Permissions {
        Permissions(contents: contents.toDomain(), enrollments: enrollments.toDomain(), finances: finances.toDomain(), managements: managements.toDomain())
    }
}

extension PermissionContentDTO {
    func toDomain() -> PermissionContent {
        return PermissionContent(courses: courses.toDomain(), ebooks: ebooks.toDomain(), quizzes: quizzes.toDomain())
    }
}

extension PermissionItemDTO {
    func toDomain() -> PermissionItem {
        return PermissionItem(id: id, name: name)
    }
}

extension [PermissionItemDTO] {
    func toDomain() -> [PermissionItem] {
        map { $0.toDomain()}
    }
}



