//
//  EnrollmentOptions.swift
//  EMLE Teams
//
//  Created by iOSAYed on 09/08/2024.
//

import Foundation

enum EnrollmentOptions {
    case details
    case decline
    case warning
    case resolve
    case deactivate
}


extension EnrollmentOptions {
    var dialogTitle:String {
        switch self {
        case .details:
            return ""
        case .decline:
            return ""
        case .warning:
            return ""
        case .resolve:
            return FinanceStrings.resolveLearnerDebit.localized
        case .deactivate:
            return FinanceStrings.deactivateLearner.localized
        }
    }
    
    var dialogMessage:String {
        switch self {
        case .details:
            return ""
        case .decline:
            return ""
        case .warning:
            return ""
        case .resolve:
            return FinanceStrings.resolveDialogMessage.localized
        case .deactivate:
            return FinanceStrings.deactivateDialogMessage.localized
        }
    }
    
    var dialogYesButtonTitle:String {
        switch self {
        case .details:
            return ""
        case .decline:
            return ""
        case .warning:
            return ""
        case .resolve:
            return FinanceStrings.yesReslove.localized
        case .deactivate:
            return FinanceStrings.yesDeactivate.localized
        }
    }
    
}
