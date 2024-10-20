//
//  MemberOptions.swift
//  EMLE Teams
//
//  Created by iOSAYed on 20/09/2024.
//

import Foundation
enum MemberOptions {
    case viewLogs
    case editMember
    case deactivate
    case removeMember
}


extension MemberOptions {
    var dialogTitle:String {
        switch self {
        case .viewLogs:
            return ""
        case .editMember:
            return ""
        case .deactivate:
            return FinanceStrings.resolveLearnerDebit.localized
        case .removeMember:
            return FinanceStrings.deactivateLearner.localized
        }
    }
    
    var dialogMessage:String {
        switch self {
        case .viewLogs:
            return ""
        case .editMember:
            return ""
        case .deactivate:
            return FinanceStrings.deactivateDialogMessage.localized
        case .removeMember:
            return "remove"
        }
    }
    
    var dialogYesButtonTitle:String {
        switch self {
        case .viewLogs:
            return ""
        case .editMember:
            return ""
        case .deactivate:
            return ""
        case .removeMember:
            return FinanceStrings.yesDeactivate.localized
        }
    }
    
}
