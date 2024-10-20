//
//  CourseFifthStepView.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 17/09/2024.
//

import Foundation
import EMLECore
import SwiftUI

struct CourseFifthStepView: View {
    @ObservedObject var viewModel: AddNewCourseViewModel

    var body: some View {
        VStack(alignment: .leading) {
            StepHeaderView(title: viewModel.addCourseSteps.headerTitle, subTitle: viewModel.addCourseSteps.headerSubtitle)
            
            ForEach(AccessCourseType.allCases, id: \.self) { option in
                CustomRadioButton(
                    title: option.rawValue,
                    isSelected: viewModel.selectedAccessCourse == option,
                    action: {
                        viewModel.selectedAccessCourse = option
                    }
                )
            }
            .padding(.horizontal, .md)
            .padding(.vertical, .xSm)
            
            Spacer()

        }
        .padding(.horizontal, .xSm)
    }
}
