//
//  Requestable.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 12/10/2024.
//


// MARK: - Requestable
struct Requestable {
    let id: Int
    let name: String
}

extension Requestable {
    static let placeholder = Requestable(id: -1, name: "Zaghloul")
}
