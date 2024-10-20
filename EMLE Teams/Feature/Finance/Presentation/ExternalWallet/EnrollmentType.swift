//
//  EnrollmentType.swift
//  EMLE Teams
//
//  Created by iOSAYed on 20/07/2024.
//

import SwiftUI
import EMLECore

enum EnrollmentType: Int {
    case Automated = 1
    case Manual = 2
    case Request = 3
}


extension EnrollmentType {
    var title:String {
        switch self {
        case .Automated:
            return FinanceStrings.automated.localized
        case .Manual:
            return FinanceStrings.manual.localized
        case .Request:
            return FinanceStrings.request.localized
        }
    }
    
    var backgroundColor: ColorStyle {
        switch self {
        case .Automated:
            return .warning
        case .Manual:
            // should change this color to manual color
            return .primary
        case .Request:
            return .success
        }
    }
}
