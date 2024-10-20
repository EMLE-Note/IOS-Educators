//
//  SecretaryDTO.swift
//  EMLE Teams
//
//  Created by iOSAYed on 20/07/2024.
//

import Foundation

class SecretaryDTO: Codable {
    let id: Int
    let name: String
    let status, is_instructor: Int
    let role: String
    let image: String?
    let balance: Double
}
