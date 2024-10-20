//
//  ChildrenFolderDTO.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 20/08/2024.
//

import Foundation

class ChildrenFolderDTO: Codable {
    let id: Int
    let name: String
    let sort, type, level: Int
    let is_visible: Bool
    let videos_duration, books_count, quiz_count: Int
    let parent: ChildDTO?
    let children: [ChildDTO]
    let course: CourseDTO
    let materials: [MeterialDTO]?
    let folders_count: Int
}
