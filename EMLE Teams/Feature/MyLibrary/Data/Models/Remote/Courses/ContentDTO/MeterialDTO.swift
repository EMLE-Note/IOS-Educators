//
//  MeterialDTO.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 17/08/2024.
//

import Foundation

// MARK: - MeterialDTO
class MeterialDTO: Codable {
    let id: Int
    let name: String
    let sort, type: Int
    let should_pass, is_free, is_visible: Bool
    let materialable: MaterialableDTO
}
