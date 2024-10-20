//
//  TargetRequestFromData.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 19/09/2024.
//

import Foundation
import EMLECore

// MARK: - Target
class TargetRequestFromData: Codable {
    let name: String?
    let institution_id, type_id, field_id, students_count: Int?

    // Initializer
    init(name: String? = nil,
         institution_id: Int? = nil,
         type_id: Int? = nil,
         field_id: Int? = nil,
         students_count: Int? = nil) {
        
        self.name = name
        self.institution_id = institution_id
        self.type_id = type_id
        self.field_id = field_id
        self.students_count = students_count
    }

    // Form data generation with indexed properties
    func formData(index: Int) -> FormData {
        var data: FormData = [:]
        if let name = name {
            data["targets[\(index)][name]"] = name
        }
        if let institution_id = institution_id {
            data["targets[\(index)][institution_id]"] = institution_id
        }
        if let type_id = type_id {
            data["targets[\(index)][type_id]"] = type_id
        }
        if let field_id = field_id {
            data["targets[\(index)][field_id]"] = field_id
        }
        if let students_count = students_count {
            data["targets[\(index)][students_count]"] = students_count
        }
        return data
    }
}

