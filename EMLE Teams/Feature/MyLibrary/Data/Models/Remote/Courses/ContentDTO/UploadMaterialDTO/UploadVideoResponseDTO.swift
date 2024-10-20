//
//  UploadVideoResponseDTO.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 06/10/2024.
//

import Foundation

// MARK: - UploadVideoResponseDTO
class UploadVideoResponseDTO: Codable {
    let id: Int?
    let name: String?
    let sort, type: Int?
    let should_pass, is_free, is_visible: Bool?
    let materialable: MaterialableDTO?
}
