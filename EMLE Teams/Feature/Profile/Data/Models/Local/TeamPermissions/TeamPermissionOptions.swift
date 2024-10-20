//
//  TeamPermissionOptions.swift
//  EMLE Teams
//
//  Created by iOSAYed on 14/09/2024.
//

import Foundation

enum TeamPermissionOptions {
    case contents
    case enrollments
    case finances
    case managements
}

extension TeamPermissionOptions {
    var title: String {
        switch self {
        case .contents:
             return "Contents"
        case .enrollments:
            return "Enrollments"
        case .finances:
            return "Finances"
        case .managements:
            return "Managements"
        }
    }
}
