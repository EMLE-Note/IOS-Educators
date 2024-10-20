//
//  ChildrenFolderMapper.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 20/08/2024.
//

import Foundation

extension ChildrenFolderDTO {
    func toDomain() throws -> ChildrenFolder {
        return try ChildrenFolder(childrenId: id, name: name, sort: sort, type: type, level: level, isVisible: is_visible, videosDuration: videos_duration, booksCount: books_count, quizCount: quiz_count, parent: parent?.toDomain(), children: children.toDomain(), course: course.toDomain(), materials: materials?.toDomain(), foldersCount: folders_count)
    }
}

extension ChildDTO {
    func toDomain() -> Child {
        return Child(id: id, name: name, sort: sort, type: type, level: level, isVisible: is_visible, videosDuration: videos_duration, booksCount: books_count, quizCount: quiz_count)
    }
}

extension [ChildDTO] {
    func toDomain() throws -> [Child] {
        try map { try $0.toDomain() }
    }
}
