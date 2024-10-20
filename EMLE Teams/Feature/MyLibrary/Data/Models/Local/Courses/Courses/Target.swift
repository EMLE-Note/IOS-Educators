//
//  Target.swift
//  EMLE Teams
//
//  Created by iOSAYed on 16/08/2024.
//

import Foundation
import EMLECore

struct Target: Hashable, Identifiable {
    
    var id: UUID = UUID()
    var targetId: Int
    var name: String
    var field: StudyingField
    var institution: Institution
    var type: EducationStatus
    
    static func == (lhs: Target, rhs: Target) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    func toTargetRequestForm(studentsCount: Int? = nil) -> TargetRequestFrom {
            return TargetRequestFrom(
                name: self.name,
                institution_id: self.institution.institutionId,
                type_id: self.type.educationStatusId,
                field_id: self.field.fieldId,
                students_count: studentsCount
            )
        }
}

extension Target {
    static let placeholder = Target(targetId: -1, name: "", field: .emptyPlaceholder, institution: .emptyPlaceholder, type: .emptyPlaceholder)
}
