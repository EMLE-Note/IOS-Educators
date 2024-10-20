//
//  AddNewCourseView.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 17/09/2024.
//

import SwiftUI
import EMLECore


struct AddNewCourseView: View {
    @StateObject var viewModel: AddNewCourseViewModel
    
    init(coordinator: AddNewCourseViewCoordinating) {
        _viewModel = StateObject(wrappedValue: AddNewCourseViewModel(coordinator: coordinator))
    }

    var body: some View {
        MainView(viewModel: viewModel) {
            navigationBar
            
            progressView
            
            currentStepView
            if !(viewModel.addCourseSteps == .seventh ) {
                StepNavigationButtons(viewModel: viewModel, backAction: viewModel.NextButtonAction(), nextAction: viewModel.nextAction, isNextButtonDisabled: viewModel.addCourseSteps.nextButtonDisabled(viewModel: viewModel))
            }
            
            Spacer()
        }
    }
    
    @ViewBuilder
    private var currentStepView: some View {
        switch viewModel.addCourseSteps {
        case .first:
            CourseFirstStepView(viewModel: viewModel)
        case .second:
            CourseSecondStepView(viewModel: viewModel)
        case .third:
            CourseThirdStepView(viewModel: viewModel)
        case .fourth:
            CourseFourthStepView(viewModel: viewModel)
        case .fifth:
            CourseFifthStepView(viewModel: viewModel)
        case .sixth:
            CourseSixthStepView(viewModel: viewModel)
        case .seventh:
            CourseSeventhStepView(viewModel: viewModel)
        }
    }
}

struct AddNewCourseView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewCourseView(coordinator: AddNewCourseViewCoordinator(navigationController: UINavigationController(), tabBarController: MainTabBarController()))
    }
}

extension AddNewCourseView {
    private var progressView: some View {
        HStack {
            CustomBarProgressView(steps: 7, currentStep: viewModel.addCourseSteps.rawValue)
        }
    }
}

// MARK: - Navigation View -

extension AddNewCourseView {
    private var navigationBar: some View {
        HStack {
            CustomNavigationBar.Checkout(title: LibraryStrings.addNewQBank.localized,
                                         backAction: viewModel.nextButtonAction())
                .padding(.bottom, .xxSm)
                .customBackground(.container)
                .padding(.horizontal, defaultHPadding)
        }
        .customBackground(.container)
        .padding(.bottom, .md)
    }
}

