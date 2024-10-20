//
//  FolderDTO.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 17/08/2024.
//

import Foundation

class FolderDTO: Codable {
    let id: Int
    let name: String
    let sort: Int
    let type: Int
    let level: Int?
    let videos_duration: Int
    let books_count: Int
    let quiz_count: Int
    let is_visible: Bool
    let folders_count: Int?
    
    let children: [FolderDTO]?
    let materials: [MeterialDTO]?
    let parent: ParentFolderDTO?
}
