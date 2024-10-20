//
//  ParentFolderDTO.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 24/08/2024.
//

import Foundation

class ParentFolderDTO: Codable {
    let id: Int
    let name: String
    let sort, type, level: Int
    let is_visible: Bool
    let videos_duration, book_count, quiz_count: Int?
}
