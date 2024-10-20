//
//  EditTargetDTO.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 15/09/2024.
//

import Foundation
import EMLECore

class EditTargetDTO: Codable, RequestDTO {
    let id: Int?
    let name: String
    let institution_id: Int
    let type_id: Int
    let field_id: Int

    init(id: Int?, name: String, institution_id: Int, type_id: Int, field_id: Int) {
        self.id = id
        self.name = name
        self.institution_id = institution_id
        self.type_id = type_id
        self.field_id = field_id
    }

    init(target: Target) {
        self.id = target.targetId
        self.name = target.name
        self.institution_id = target.institution.institutionId
        self.type_id = target.type.educationStatusId
        self.field_id = target.field.fieldId
    }
}

