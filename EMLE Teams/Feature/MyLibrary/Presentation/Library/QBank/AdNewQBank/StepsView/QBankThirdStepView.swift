//
//  QBankThirdStepView.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 12/09/2024.
//

import SwiftUI
import EMLECore

struct QBankThirdStepView: View {
    @ObservedObject var viewModel: AddQBankViewModel

    var body: some View {
        VStack(alignment: .leading) {
            StepHeaderView(title: viewModel.addQBankSteps.headerTitle, subTitle: viewModel.addQBankSteps.headerSubtitle)
            ToggleView(isOn: $viewModel.isShowExpirationDate, title: LibraryStrings.expirationDate.localized)
            
            if viewModel.isShowExpirationDate {
                GeometryReader { geometry in
                    HStack(spacing: .md) {
                        CustomTextField(title: LibraryStrings.durationOfQBank.localized,
                                        placeholder: LibraryStrings.durationOfQBankPH.localized,
                                        value: $viewModel.durationDate,
                                        borderStateColor: .neutral)
                            .keyboardType(.numberPad)
                            .frame(width: (geometry.size.width - 48) * 2 / 3)

                        CustomTextField(title: "",
                                        placeholder: LibraryStrings.days.localized,
                                        value: $viewModel.durationType,
                                        borderStateColor: .neutral,
                                        hasChevron: true,
                                        disable: true)
                        .onTapGesture {
                            viewModel.onDurationDateType()
                        }
                        .frame(width: (geometry.size.width - 48) / 3)
                    }
                    .padding(.horizontal, .md)
                    .padding(.trailing, .md)
                }

            }
            
            Spacer()
        }
    }
}
