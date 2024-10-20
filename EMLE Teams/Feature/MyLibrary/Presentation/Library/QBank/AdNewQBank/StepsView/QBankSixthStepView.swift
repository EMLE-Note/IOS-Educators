//
//  QBankSixthStepView.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 12/09/2024.
//

import SwiftUI
import EMLECore

struct QBankSixthStepView: View {
    @ObservedObject var viewModel: AddQBankViewModel

    var body: some View {
        VStack(alignment: .leading) {
            StepHeaderView(title: viewModel.addQBankSteps.headerTitle, subTitle: viewModel.addQBankSteps.headerSubtitle)
            VStack {
                VStack(spacing: .xxBig) {
                    HStack(spacing: .md) {
                        Image.downloadTem
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                        
                        Text(LibraryStrings.downloadSampleTemplate.localized)
                            .customStyle(.bodyMedium, .subtitle)
                        
                    }
                    .frame(maxWidth: .infinity)
                    .frame(maxHeight: 50)
                    .customBackground(.onPrimary)
                    .withCardBorder(bordered: true,
                                    borderColor: .neutral)
                    
                    VStack(spacing: .md) {
                        Image.excelIcon
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                        
                        Text(viewModel.fileName)
                            .customStyle(.bodyMedium, .subtitle)
                        
                    }
                    .frame(maxWidth: .infinity)
                    .frame(maxHeight: 90)
                    .customBackground(.primaryOpacity(opacity: 0.1))
                    .customCornerRadii(.xSm, corners: .allCorners)
                    .onTapGesture {
                        viewModel.isShowingPicker = true
                    }
                }
            }
            .padding()
            
            Spacer()
            
            PrimaryButton(title: LibraryStrings.previewQuestion.localized, action: {
                viewModel.previewQuestionTapped()
            })
            .disabled(viewModel.addQBankSteps.nextButtonDisabled(viewModel: viewModel))
            .clipShape(Capsule())
            .padding()
        }
    }
}

