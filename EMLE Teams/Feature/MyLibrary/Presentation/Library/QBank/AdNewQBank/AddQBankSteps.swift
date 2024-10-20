//
//  AddQBankSteps.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 07/09/2024.
//

import Foundation

enum QBankType {
    case certificate
    case referencePreviousExam
    case reference
    case referencesSyllabus
}

enum AddQBankSteps: Int {
    case first = 0
    case second = 1
    case third = 2
    case fourth = 3
    case fifth = 4
    case sixth = 5
    case seventh = 6
    case questions = 7
}

extension AddQBankSteps {
    var headerTitle: String {
        switch self {
        case .first:
            return LibraryStrings.addYourQbnk.localized
        case .second:
            return LibraryStrings.makeItEasierForStudentsToFind.localized
        case .third:
            return LibraryStrings.specifyTheExpirationDate.localized
        case .fourth:
            return LibraryStrings.getMoreSalse.localized
        case .fifth:
            return LibraryStrings.uploadYourQBankCover.localized
        case .sixth:
            return LibraryStrings.importQbank.localized
        case .seventh:
            return LibraryStrings.checkInvalidQuestionVerifiction.localized
        case .questions: return ""
        }
    }
    
    var headerSubtitle: String {
        switch self {
        case .first:
            return ""
        case .second:
            return ""
        case .third:
            return ""
        case .fourth:
            return ""
        case .fifth:
            return LibraryStrings.weRecommendYouToAddThumbnailForQbank.localized
        case .sixth:
            return LibraryStrings.youCanImportYourQuestionBank.localized
        case .seventh:
            return ""
        case .questions: return ""
        }
    }
    
    func nextButtonDisabled(viewModel: AddQBankViewModel) -> Bool {
        switch self {
        case .first:
            return !viewModel.isNextButtonEnabledFirst
        case .second:
            return !viewModel.isNextButtonEnabledSecond
        case .third:
            return viewModel.isShowExpirationDate ? viewModel.durationDate.isEmpty : false
        case .fourth:
            return viewModel.isEnableTrial ? viewModel.durationTrial.isEmpty : false
        case .fifth:
            return false
        case .sixth:
            return viewModel.questions.isEmpty
        case .seventh:
            return false
        case .questions: return false
        }
    }
}
