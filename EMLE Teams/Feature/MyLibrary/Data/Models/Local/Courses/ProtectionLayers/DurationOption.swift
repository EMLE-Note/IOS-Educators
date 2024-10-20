//
//  DurationOption.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 25/08/2024.
//

import Foundation
import EMLECore

enum DurationOption: Int, CaseIterable, CustomPickerItem, Identifiable {
    case tenMinutes = 10
    case fifteenMinutes = 15
    case twentyMinutes = 20
    case thirtyMinutes = 30
    case sixtyMinutes = 60

    var id: Int { rawValue }

    var displayName: String {
        "\(rawValue) min"
    }
}
