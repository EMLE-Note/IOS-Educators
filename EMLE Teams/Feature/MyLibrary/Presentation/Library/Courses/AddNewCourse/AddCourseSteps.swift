//
//  AddCourseSteps.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 17/09/2024.
//

import Foundation

enum ExpirationDateType: String, CaseIterable {
    case nothaveExpirationDate
    case hasExpirationDate
    
    var localizedDescription: String {
        switch self {
        case .nothaveExpirationDate:
            return LibraryStrings.doesNotHaveExpirationDate.localized
        case .hasExpirationDate:
            return LibraryStrings.hasExpirationDate.localized
        }
    }
}

enum AccessCourseType: String, CaseIterable {
    case allowOffline
    case allowOnline
    
    var localizedDescription: String {
        switch self {
        case .allowOffline:
            return LibraryStrings.allowOfflineAccess.localized
        case .allowOnline:
            return LibraryStrings.allowOnlineAccess.localized
        }
    }
}

enum AddCourseSteps: Int {
    case first = 0
    case second = 1
    case third = 2
    case fourth = 3
    case fifth = 4
    case sixth = 5
    case seventh = 6
}

extension AddCourseSteps {
    var headerTitle: String {
        switch self {
        case .first:
            return LibraryStrings.addYourCourseSettings.localized
        case .second:
            return LibraryStrings.makeItEasierStudentCourse.localized
        case .third:
            return LibraryStrings.seheduleCourse.localized
        case .fourth:
            return LibraryStrings.addCourseExpirationDate.localized
        case .fifth:
            return LibraryStrings.allowOffline.localized
        case .sixth:
            return LibraryStrings.selectCourseProtectionLayer.localized
        case .seventh:
            return LibraryStrings.uploadYourCourseImage.localized
        }
    }
    
    var headerSubtitle: String {
        switch self {
        case .first:
            return ""
        case .second:
            return ""
        case .third:
            return LibraryStrings.controlWhenYourContentLivePublished.localized
        case .fourth:
            return ""
        case .fifth:
            return LibraryStrings.weRecommendYouToEnableOffline.localized
        case .sixth:
            return ""
        case .seventh:
            return LibraryStrings.weRecommendYouAddThumbnailForCourse.localized
        }
    }
    
    func nextButtonDisabled(viewModel: AddNewCourseViewModel) -> Bool {
        switch self {
        case .first:
            return !viewModel.isNextButtonEnabledFirst
        case .second:
            return viewModel.isPresentCustomSheetView ? viewModel.canAddNewTarget : false
        case .third:
            return false
        case .fourth:
            return false
        case .fifth:
            return false
        case .sixth:
            return false
        case .seventh:
            return false
        }
    }
}
