//
//  Team.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 21/08/2024.
//

import Foundation
import EMLECore

// MARK: - Team
struct Team: Identifiable {
    
    let id: UUID = UUID()
    let teamId: Int
    let name, type: String
    let about: String?
    let situation: Int?
    let hasCurrentDeal: Bool?
    let image: ImageUrl?
    let owner: Owner
    let createdAt, updatedAt: String
}

extension Team {
    static let placeholder = Team(
        teamId: 0,
        name: "Dev_10",
        type: "",
        about: "",
        situation: 1,
        hasCurrentDeal: false,
        image: nil,
        owner: .placeholder,
        createdAt: "",
        updatedAt: ""
    )
    
    static let empty: Team = {
        Team(teamId: 0,
             name: "",
             type: "",
             about: "",
             situation: 1,
             hasCurrentDeal: false,
             image: nil,
             owner: .placeholder,
             createdAt: "",
             updatedAt: "")
    }()
}

extension [Team] {
    static let placeholder: [Team] = {
        var placeholder: [Team] = []
        
        for i in 0..<4 {
            placeholder.append(.placeholder)
        }
        
        return placeholder
    }()
}
