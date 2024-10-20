//
//  CousesDetailsType.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 13/08/2024.
//

import Foundation
import SwiftUI

enum CousesDetailsType: Int {
    case content
    case student
    case all
}

enum FilterStudentOptions: String, CaseIterable {
    case latest = "Duration : latest to oldest"
    case oldest = "Duration : oldest to latest"
    
    var localizedDescription: String {
        switch self {
        case .latest:
            return LibraryStrings.latestToOldest.localized
        case .oldest:
            return LibraryStrings.oldestToLatest.localized
        }
    }
}

enum FilterStatusTypeOptions: String, CaseIterable {
    case requestActivation = "Activated"
    case automatedEnrollment = "Deactivated"
    
    var localizedDescription: String {
        switch self {
        case .requestActivation:
            return LibraryStrings.activated.localized
        case .automatedEnrollment:
            return LibraryStrings.deactivated.localized
        }
    }
}

enum OptionType: Hashable {
    case hideFolder(folderId: Int, isVisible: Bool)
    case deletePermanently(folderId: Int)
    case editSecurity(security: Security)
    case toggleActivation(enrollmentId: Int, isActive: Bool)

    var icon: Image {
        switch self {
        case .hideFolder: return Image.hideFolder
        case .deletePermanently: return Image.deletePermanently
        case .editSecurity: return Image.editSecurityLayers
        case .toggleActivation: return Image.deactivate
        }
    }

    var title: String {
        switch self {
        case .hideFolder(_, let isVisible):
            return isVisible ? LibraryStrings.hideFolder.localized : LibraryStrings.showFolder.localized
        case .deletePermanently: return LibraryStrings.deletePermanently.localized
        case .editSecurity: return LibraryStrings.editSecurityLayers.localized
        case .toggleActivation(_, let isActive):
            return isActive ? LibraryStrings.deactivate.localized : LibraryStrings.activate.localized
        }
    }

    var description: String {
        switch self {
        case .hideFolder(_, let isVisible):
            return isVisible ? LibraryStrings.hideFolderFromCourse.localized : LibraryStrings.showFolderFromCourse.localized
        case .deletePermanently: return LibraryStrings.deleteFilesFromServers.localized
        case .editSecurity: return LibraryStrings.adjustSecurityLayers.localized
        case .toggleActivation(_, let isActive):
            return isActive ? LibraryStrings.disableLearnerAccessCourse.localized : LibraryStrings.enableLearnerAccessCourse.localized
        }
    }

    enum OptionType: Hashable {
        case hideFolder(folderId: Int, isVisible: Bool)
        case deletePermanently(folderId: Int)
        case editSecurity(security: Security)
        case toggleActivation(enrollmentId: Int, isActive: Bool)

        static func == (lhs: OptionType, rhs: OptionType) -> Bool {
            switch (lhs, rhs) {
            case let (.hideFolder(lId, lIsVisible), .hideFolder(rId, rIsVisible)):
                return lId == rId && lIsVisible == rIsVisible
            case let (.deletePermanently(lId), .deletePermanently(rId)):
                return lId == rId
            case let (.editSecurity(lSecurity), .editSecurity(rSecurity)):
                return lSecurity == rSecurity
            case let (.toggleActivation(lId, lIsActive), .toggleActivation(rId, rIsActive)):
                return lId == rId && lIsActive == rIsActive
            default:
                return false
            }
        }

        func hash(into hasher: inout Hasher) {
            switch self {
            case let .hideFolder(folderId, isVisible):
                hasher.combine(folderId)
                hasher.combine(isVisible)
            case let .deletePermanently(folderId):
                hasher.combine(folderId)
            case let .editSecurity(security):
                hasher.combine(security)
            case let .toggleActivation(enrollmentId, isActive):
                hasher.combine(enrollmentId)
                hasher.combine(isActive)
            }
        }
    }
}
