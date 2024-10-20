//
//  ChildrenFolder.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 20/08/2024.
//

import Foundation

struct ChildrenFolder: Hashable, Identifiable {
    let id = UUID()
    let childrenId: Int
    let name: String
    let sort, type, level: Int
    let isVisible: Bool
    let videosDuration, booksCount, quizCount: Int
    let parent: Child?
    let children: [Child]
    let course: Course
    let materials: [FolderMaterial]?
    let foldersCount: Int
    
    static func == (lhs: ChildrenFolder, rhs: ChildrenFolder) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension ChildrenFolder {
    static let placeholder = ChildrenFolder(childrenId: 0, name: "", sort: 0, type: 0, level: 0, isVisible: false, videosDuration: 0, booksCount: 0, quizCount: 0, parent: .placeholder, children: [], course: .placeholder, materials: [], foldersCount: 0)
}
