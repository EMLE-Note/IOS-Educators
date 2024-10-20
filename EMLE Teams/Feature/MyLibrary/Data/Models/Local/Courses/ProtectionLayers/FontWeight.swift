//
//  FontWeight.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 25/08/2024.
//

import Foundation
import EMLECore

enum FontWeight: String, CaseIterable, CustomPickerItem, Identifiable {
    case thin = "Thin"
    case regular = "Normal"
    case semiBold = "SemiBold"
    case bold = "Bold"
    case black = "Black"

    var id: String { rawValue }

    var displayName: String {
        rawValue
    }

    var value: Int {
        switch self {
        case .thin:
            return 100
        case .regular:
            return 400
        case .semiBold:
            return 600
        case .bold:
            return 700
        case .black:
            return 900
        }
    }
    
    static func fontWeight(for value: Int) -> FontWeight? {
        return FontWeight.allCases.first { $0.value == value }
    }
}
