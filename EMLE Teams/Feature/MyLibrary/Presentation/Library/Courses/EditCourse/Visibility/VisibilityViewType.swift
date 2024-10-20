//
//  VisibilityViewType.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 13/08/2024.
//

import Foundation

enum VisibilityPublishType: String, CaseIterable {
    case Public
    case Private 
    
    var title: String {
        switch self {
        case .Private:
            return LibraryStrings.Private.localized
        case .Public:
            return LibraryStrings.Public.localized
        }
    }
    
    var desction: String {
        switch self {
        case .Private:
            return LibraryStrings.onlyCanViewCourse.localized
        case .Public:
            return LibraryStrings.courseWillBeVisibleAnyone.localized
        }
    }
}
