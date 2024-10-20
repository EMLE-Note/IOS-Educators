//
//  DurationDateType.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 10/09/2024.
//

import Foundation
import EMLECore

enum DurationDateType: String, CaseIterable, CustomPickerItem, Identifiable {
    case days = "Days"
    case months = "Months"
    case years = "Years"
    
    var id: String { rawValue }
    
    var displayName: String {
        rawValue
    }
}
