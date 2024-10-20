//
//  GroupDTO.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 21/08/2024.
//

import Foundation

// MARK: - Group
struct GroupDTO: Codable {
    let id: Int
    let name: String
    let courses: [CourseDTO]?
}
