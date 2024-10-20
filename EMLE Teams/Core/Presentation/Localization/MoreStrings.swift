//
//  MoreStrings.swift
//  EMLE Learners
//
//  Created by Abdelrhman Sultan on 08/05/2024.
//

import Foundation
import EMLECore

enum MoreStrings: String, Localizable {
    
    var tableName: String {
        "MoreStrings"
    }
    
    case editProfile = "edit_profile"
    case enrollment
    case helpSupport = "help_support"
    case sendFeedback = "send_feedback"
    case aboutEMLE = "about_e_m_l_e"
    case shareApp = "share_app"
    case logout = "logout"
    
    case changePhoto = "change_photo"
    case saveChanges = "save_changes"
    
    case country = "country"
    
    case areYouSureYouWantToLogout = "are_you_sure_you_want_to_logout"
}
