//
//  MaterialType.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 13/10/2024.
//

import Foundation
import EMLECore

enum ActivationMaterialType: String, CaseIterable, CustomPickerItem, Identifiable {
    case course = "Course"
    case qbank = "QBank"
    case ebook = "EBook"
    case group = "Group"
    case placeholder = "" 

    var id: String { rawValue }
    
    var displayName: String {
        switch self {
        case .placeholder:
            return ""
        default:
            return rawValue
        }
    }
}

struct ActivationMaterialName: TreeItem, Identifiable {
    var id: Int
    
    var name: String
    var courses: [Course]?
   
    var displayName: String { name }
}

extension ActivationMaterialName {
    static var placeholder: ActivationMaterialName {
        return ActivationMaterialName(id: 0, name: "")
    }
}
