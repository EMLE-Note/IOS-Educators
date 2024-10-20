//
//  InstitutionDTO.swift
//  EMLE Teams
//
//  Created by iOSAYed on 16/08/2024.
//

import Foundation

class InstitutionDTO: Codable {
    let id: Int
    let name: String
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}
