//
//  Owner.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 21/08/2024.
//

import Foundation
import EMLECore

// MARK: - Owner
struct Owner {
    let id: Int
    let name: String
    let image: ImageUrl?
    let overview: String?
    let jobTitle: String
    let field: StudyingField
}

extension Owner {
    static let placeholder = Owner(id: 0, name: "", image: nil, overview: "", jobTitle: "", field: .placeholder)
}
