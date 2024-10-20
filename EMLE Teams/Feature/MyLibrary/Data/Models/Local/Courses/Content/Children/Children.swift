//
//  Children.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 20/08/2024.
//

import Foundation

struct Child: Codable {
    let id: Int
    let name: String
    let sort, type, level: Int
    let isVisible: Bool
    let videosDuration, booksCount, quizCount: Int
}

extension Child {
    static let placeholder = Child(id: 0, name: "", sort: 0, type: 0, level: 0, isVisible: false, videosDuration: 0, booksCount: 0, quizCount: 0)
}
