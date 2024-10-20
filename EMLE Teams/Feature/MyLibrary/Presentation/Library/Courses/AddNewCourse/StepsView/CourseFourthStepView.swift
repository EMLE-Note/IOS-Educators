//
//  CourseFourthStepView.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 17/09/2024.
//

import Foundation
import EMLECore
import SwiftUI

struct CourseFourthStepView: View {
    @ObservedObject var viewModel: AddNewCourseViewModel

    var body: some View {
        VStack(alignment: .leading) {
            StepHeaderView(title: viewModel.addCourseSteps.headerTitle, subTitle: viewModel.addCourseSteps.headerSubtitle)
            
            ForEach(ExpirationDateType.allCases, id: \.self) { option in
                CustomRadioButton(
                    title: option.localizedDescription,
                    isSelected: viewModel.selectedDateOption == option,
                    action: {
                        viewModel.selectedDateOption = option
                    }
                )
            }
            .padding(.horizontal, .md)
            .padding(.vertical, .xSm)
            
            if viewModel.selectedDateOption == .hasExpirationDate {
                expirationDate
            }
            
            Spacer()
        }
        .padding(.horizontal, .xSm)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

extension CourseFourthStepView {
    private var expirationDate: some View {
        VStack(alignment: .leading) {
            Text(LibraryStrings.expirtationDur.localized)
                .customStyle(.subheadline, .onSurface)
            
            HStack {
                Image.calendar
                    .resizable()
                    .frame(width: 28, height: 28)
                    .padding()
                
                TextField(LibraryStrings.courseExpirationDatePH.localized, text: $viewModel.duration)
                    .customStyle(.subheadline, .onSurface)
                    .padding(.vertical, .xxSm)
            }
            .customBackground(.onPrimary)
            .withCardBorder(backgroundColor: .onPrimary, cornerRadius: .xSm, borderColor: .neutral)
        }
        .padding(.horizontal, .md)
        .padding(.vertical, .md)
    }
}
