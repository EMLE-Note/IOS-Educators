//
//  CourseThirdStepView.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 17/09/2024.
//

import Foundation
import EMLECore
import SwiftUI

struct CourseThirdStepView: View {
    @ObservedObject var viewModel: AddNewCourseViewModel

    var body: some View {
        VStack(alignment: .leading) {
            StepHeaderView(title: viewModel.addCourseSteps.headerTitle, subTitle: viewModel.addCourseSteps.headerSubtitle)
            
            VStack(alignment: .leading) {
                Text(LibraryStrings.schedule.localized)
                    .customStyle(.subheadline, .onSurface)
                    .padding(.xSm)
                
                CustomTextField(title: LibraryStrings.publishAsPublic.localized,
                                placeholder: LibraryStrings.selectDate.localized,
                                value: $viewModel.publishDate,
                                borderStateColor: .neutral)
                .disabled(true)
                .padding(.horizontal, .xBig)
                .onTapGesture {
                    viewModel.isPickerVisible.toggle()
                }
                
                CustomDatePicker(selectedDateString: $viewModel.publishDate, isVisible: $viewModel.isPickerVisible)
                
                Spacer()
            }
            .padding()
        }
    }
}
