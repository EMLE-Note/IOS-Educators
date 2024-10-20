//
//  ParentFolder.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 24/08/2024.
//

import Foundation

struct ParentFolder {
    let id: Int
    let name: String
    let sort, type, level: Int
    let isVisible: Bool
    let videosDuration, booksCount, quizCount: Int
}

extension ParentFolder {
    static let placeholder = ParentFolder(id: 0, name: "", sort: 0, type: 0, level: 0, isVisible: false, videosDuration: 0, booksCount: 0, quizCount: 0)
}
