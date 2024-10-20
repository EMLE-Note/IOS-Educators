//
//  QBankFourthStepView.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 12/09/2024.
//

import SwiftUI
import EMLECore

struct QBankFourthStepView: View {
    @ObservedObject var viewModel: AddQBankViewModel

    var body: some View {
        VStack(alignment: .leading) {
            StepHeaderView(title: viewModel.addQBankSteps.headerTitle, subTitle: viewModel.addQBankSteps.headerSubtitle)
            ToggleView(isOn: $viewModel.isEnableTrial, title: LibraryStrings.enableTrial.localized)
            if viewModel.isEnableTrial {
                GeometryReader { geometry in
                    HStack(spacing: .md) {
                        CustomTextField(title: LibraryStrings.durationOfTrial.localized,
                                        placeholder: LibraryStrings.durationOfTrialPH.localized,
                                        value: $viewModel.durationTrial,
                                        borderStateColor: .neutral)
                            .keyboardType(.numberPad)
                            
                    }
                    .padding(.horizontal, .md)
                    .padding(.trailing, .md)
                }

            }
            Spacer()
        }
    }
}

