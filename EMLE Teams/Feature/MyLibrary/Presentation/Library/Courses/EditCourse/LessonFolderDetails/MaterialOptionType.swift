//
//  MaterialOptionType.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 23/10/2024.
//

import Foundation
import SwiftUI

enum MaterialOptionType: Hashable {
    case downloadMaterial
    case editMaterial
    case hideLesson
    case copyLesson(materilId: Int)
    case setFreeMaterial(materilId: Int, isFree: Bool)
    case deleteLesson

    var icon: Image {
        switch self {
        case .downloadMaterial: return Image.hideFolder
        case .editMaterial: return Image.editQueation
        case .hideLesson: return Image.hideFolder
        case .copyLesson: return Image.copyIcon
        case .setFreeMaterial: return Image.freeMaterial
        case .deleteLesson: return Image.deletePermanently
        }
    }

    var title: String {
        switch self {
        case .downloadMaterial: return LibraryStrings.downloadMaterial.localized
        case .editMaterial: return LibraryStrings.editMaterial.localized
        case .hideLesson: return LibraryStrings.hideLesson.localized
        case .copyLesson: return LibraryStrings.copyLesson.localized
        case .setFreeMaterial: return LibraryStrings.setasFree.localized
        case .deleteLesson: return LibraryStrings.deleteLesson.localized
        }
    }

    var description: String {
        switch self {
        case .downloadMaterial: return ""
        case .editMaterial: return ""
        case .hideLesson: return LibraryStrings.hidenTheLessonCourse.localized
        case .copyLesson: return LibraryStrings.copyTheLessonAntherCourse.localized
        case .setFreeMaterial: return LibraryStrings.encouageLearners.localized
        case .deleteLesson: return LibraryStrings.deleteYouLessonFile.localized
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
