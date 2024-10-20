//
//  MaterialableDTO.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 17/08/2024.
//

import Foundation

// MARK: - MaterialableDTO
class MaterialableDTO: Codable {
    let duration, size, server_id: Int?
    let link: String?
    let upload_type, pages_count: Int?
    let questions: [QuestionDTO]?
    let streaming_link: String?
}
