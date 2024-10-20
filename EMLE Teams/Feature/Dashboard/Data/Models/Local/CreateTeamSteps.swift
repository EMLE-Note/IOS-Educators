//
//  CreateTeamSteps.swift
//  EMLE Teams
//
//  Created by iOSAYed on 04/09/2024.
//

import Foundation

enum CreateTeamSteps: Int {
    case first = 0
    case second = 1
    case third = 2
}

extension CreateTeamSteps {
    var headerTitle: String {
        switch self {
        case .first:
            return DashboardStrings.LetsCreateYourTeam.localized
        case .second:
            return DashboardStrings.addTeamOverview.localized
        case .third:
            return DashboardStrings.uploadYourPhoto.localized
        }
    }
    
    var headerSubtitle: String {
        switch self {
        case .first:
            return DashboardStrings.whatIsNameYouWantYourStudentsToSee.localized
        case .second:
            return DashboardStrings.tellYourStudentsMoreAboutYourAcademic.localized
        case .third:
            return DashboardStrings.helpStudentsRecognizeYourTeamWithAPhoto.localized
        }
    }
    
    func nextButtonDisabled(viewModel: CreateTeamViewModel) -> Bool {
        switch self {
        case .first:
            return viewModel.teamName.isEmpty
        case .second:
            return viewModel.overView.isEmpty
        case .third:
            return false
        }
    }
}
