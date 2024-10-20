//
//  FontSize.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 25/08/2024.
//

import Foundation
import EMLECore

enum FontSize: Int, CaseIterable, CustomPickerItem, Identifiable {
    case size16 = 16
    case size18 = 18
    case size20 = 20
    case size22 = 22
    case size24 = 24
    case size26 = 26
    case size28 = 28
    case size30 = 30

    var id: Int { rawValue }

    var displayName: String {
        "\(rawValue)"
    }
}
