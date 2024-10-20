//
//  CreateGroupResponse.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 31/08/2024.
//

import Foundation

struct GroupResponse: Identifiable {
    let id: Int
    let name: String
    let courses: [Course]
}
