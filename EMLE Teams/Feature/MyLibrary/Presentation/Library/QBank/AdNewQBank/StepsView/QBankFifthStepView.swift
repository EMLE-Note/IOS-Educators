//
//  QBankFifthStepView.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 12/09/2024.
//

import SwiftUI
import EMLECore

struct QBankFifthStepView: View {
    @ObservedObject var viewModel: AddQBankViewModel

    var body: some View {
        VStack(alignment: .leading) {
            StepHeaderView(title: viewModel.addQBankSteps.headerTitle, subTitle: viewModel.addQBankSteps.headerSubtitle)
            Group {
                let imageToShow = viewModel.didSelectImage ? Image(uiImage: viewModel.qbankImage.image) : Image.uploadImage
                imageToShow
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .customCornerRadii(.xSm, corners: .allCorners)
                    .frame(maxHeight: 150)
                    .frame(maxWidth: 350)
                    .padding(.horizontal, .md)
                    .onTapGesture {
                        viewModel.onChangeImageClick()
                    }
            }
            Text(LibraryStrings.maximumPicSize.localized)
                .customStyle(.caption1, .subtitle)
                .padding(.horizontal, .xSm)
            Spacer()
        }
    }
}

