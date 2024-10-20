//
//  CustomDialogModelConfigurator.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 11/08/2024.
//

import SwiftUI

struct CustomDialogModelConfigurator {
    static func configureModel(for type: CustomDialogType) -> CustomDialogModel {
        switch type {
        case .deleteFolder:
            CustomDialogModel(title: "Delete Folder", message: "You are about to delete this folder and all it’s content. Are you sure that you want to do this ?", buttonTitle: "Yes, Delete folder", buttonCancelTitle: "No, cancel", dialogType: .deleteFolder)
        case .deleteCourse:
            CustomDialogModel(title: "Delete Course", message: "You are about to delete the course and all it’s content. Are you sure that you want to do this ?", buttonTitle: "Yes, Delete my course", buttonCancelTitle: "No, cancel", dialogType: .deleteCourse)
        case .deactivateAll:
            CustomDialogModel(title: "Deactivate All", message: "You are about to deactivate all student from this chapter. Are you sure that you want to do this ?", buttonTitle: "Yes, Deactivate all", buttonCancelTitle: "No, cancel", dialogType: .deactivateAll)
        case .deactivateLearner:
            CustomDialogModel(title: "Deactivate Learner ", message: "You are about to deactivate this learner. Are you sure that you want to do this ? ", buttonTitle: "Yes, Deactivate", buttonCancelTitle: "No, cancel", dialogType: .deactivateLearner)
        case .deactivateCourse:
            CustomDialogModel(title: "Deactivate Course", message: "Your course will retain in our app but students will not have access to it. ", buttonTitle: "Deactivate Course", buttonCancelTitle: "Cancel", dialogType: .deleteFolder)
        }
    }
}
