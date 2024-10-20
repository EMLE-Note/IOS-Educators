//
//  QBankSecondStepView.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 12/09/2024.
//

import SwiftUI
import EMLECore

struct QBankSecondStepView: View {
    @ObservedObject var viewModel: AddQBankViewModel

    var body: some View {
        VStack(alignment: .leading) {
            StepHeaderView(title: viewModel.addQBankSteps.headerTitle, subTitle: viewModel.addQBankSteps.headerSubtitle)
            VStack {
                CustomTextField(title: LibraryStrings.certificate.localized,
                                placeholder: LibraryStrings.selectStudyFiled.localized,
                                value: .constant(viewModel.selectedCertificate.displayName),
                                borderStateColor: .neutral,
                                hasChevron: true,
                                disable: true)
                .padding(.horizontal, .md)
                .padding(.vertical, .xSm)
                .onTapGesture {
                    viewModel.presentDialog(for: .certificate)
                }
                
                CustomTextField(title: LibraryStrings.reference.localized,
                                placeholder: LibraryStrings.selectStudyFiled.localized,
                                value: .constant(viewModel.selectedReference.displayName),
                                borderStateColor: .neutral,
                                hasChevron: true,
                                disable: true)
                .padding(.horizontal, .md)
                .padding(.vertical, .xSm)
                .onTapGesture {
                    viewModel.presentDialog(for: .reference)
                }
            }
            .customBackground(.white)
            .customCornerRadii(.xSm, corners: .allCorners)
            .padding(.horizontal, .sm)
            
            Spacer()
        }
    }
}
