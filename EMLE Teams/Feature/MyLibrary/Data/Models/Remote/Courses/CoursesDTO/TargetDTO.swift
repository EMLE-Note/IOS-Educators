//
//  TargetDTO.swift
//  EMLE Teams
//
//  Created by iOSAYed on 16/08/2024.
//

import Foundation
import EMLECore

class TargetDTO: Codable {
    let id: Int
    let name: String
    let field: FieldResponseDTO?
    let institution: InstitutionResponseDTO?
    let type: TypeResponseDTO?
    
    init(id: Int, name: String, field: FieldResponseDTO, institution: InstitutionResponseDTO, type: TypeResponseDTO) {
        self.id = id
        self.name = name
        self.field = field
        self.institution = institution
        self.type = type
    }
}

public extension Institution {
    
    static let antherPlaceholder = Institution(institutionId: -1, name: "", children: [], fields: [])
}
