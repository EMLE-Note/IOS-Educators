//
//  SearchStaffResponseDTO.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 14/10/2024.
//

import Foundation
import EMLECore

class SearchStaffResponseDTO: Codable {
    let id: Int
    let type: String?
    let name: String
    let image: String?
    let register_status: String?
    let register_status_numeric: Int?
}
