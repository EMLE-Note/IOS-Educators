//
//  CustomDialogModel.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 11/08/2024.
//

import Foundation
import EMLECore

enum CustomDialogType {
    case deleteFolder
    case deleteCourse
    case deactivateAll
    case deactivateLearner
    case deactivateCourse
}

struct CustomDialogModel {
    let title: String
    let message: String
    let buttonTitle: String
    let buttonCancelTitle: String
    let dialogType: CustomDialogType
}

extension CustomDialogModel {
    static let placeholder = CustomDialogModel(title: "", message: "", buttonTitle: "", buttonCancelTitle: "", dialogType: .deleteCourse)
}

enum CustomDialogTextFieldType {
    case parent
    case lesson
}

struct CustomDialogTextFieldModel {
    let title: String
    let buttonTitle: String
    let dialogType: CustomDialogTextFieldType
}

extension CustomDialogTextFieldModel {
    static let placeholder = CustomDialogTextFieldModel(title: "Add Lesson Folder", buttonTitle: "Create Lesson folder", dialogType: .parent)
}

struct CustomRadioPickerItemModel: CustomRadioPickerItem {
    let id = UUID()
    var displayName: String
}
