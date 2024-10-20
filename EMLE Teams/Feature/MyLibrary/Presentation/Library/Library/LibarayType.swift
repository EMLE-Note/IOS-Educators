//
//  LibarayType.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 08/08/2024.
//

import Foundation
import EMLECore
import SwiftUI

enum LibarayTypeType: Int {
    case course
    case eBook
    case qBank
    case drafts
    case all
}

enum PrivacyOptions {
    case Private
    case Public
}

extension PrivacyOptions {
    var title:String {
        switch self {
        case .Private:
            return "Private"
        case .Public:
            return "Public"
        }
    }
    
    var image:String {
        switch self {
        case .Private:
            return "lock"
        case .Public:
            return "globe"
        }
    }
    
    var backgroundColor: ColorStyle {
        switch self {
        case .Private:
            return .warning
        case .Public:
            return .success
        }
    }
    
    var privacyImage: Image? {
        switch self {
        case .Private:
            return Image.eyeOff
        case .Public:
            return nil
        }
    }
}

enum QBankOptionType: Hashable {
    case editQuestion(questionId: Int)
    case deleteQuestion(questionId: Int)
    
    var icon: Image {
        switch self {
        case .editQuestion: return Image.editQueation
        case .deleteQuestion: return Image.deletePermanently
        }
    }
    
    var title: String {
        switch self {
        case .editQuestion: return LibraryStrings.editQuestionBank.localized
        case .deleteQuestion: return LibraryStrings.deletePermanently.localized
        }
    }
    
    var description: String {
        switch self {
        case .editQuestion: return ""
        case .deleteQuestion: return LibraryStrings.deleteQBankPermanently.localized
        }
    }
}
