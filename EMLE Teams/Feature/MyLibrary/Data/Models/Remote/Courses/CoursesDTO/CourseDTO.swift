//
//  CourseDTO.swift
//  EMLE Teams
//
//  Created by iOSAYed on 16/08/2024.
//

import Foundation

class CourseDTO: Codable {
    let id: Int
    let name: String
    let uuid: String?
    let overview: String?
    let image: String?
    let publish_at: String?
    let status: Int?
    let duration: Int?
    let price: Double?
    let currency: String?
    
    let students_count: Int?
    let videos_duration: Int?
    let books_count: Int?
    let quiz_count: Int?
    let team: TeamDTO?
    let targets: [TargetDTO]?
    
    let folders: [FolderDTO]?
    let security: SecurityDTO?
    
    /// Library
    let is_allowed_offline: Bool?
    let folders_count: Int?
    let groups: [GroupDTO]?
}
