//
//  GraduationYear.swift
//  EMLE Learners
//
//  Created by Abdelrhman Sultan on 22/04/2024.
//

import Foundation
import EMLECore

struct GraduationYear: CustomMenuPickerItem {
    var displayName: String
    var id: Int
    
    static func == (lhs: GraduationYear, rhs: GraduationYear) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
}

extension GraduationYear {
    static let placeholder = GraduationYear(displayName: "", id: -1)
}
