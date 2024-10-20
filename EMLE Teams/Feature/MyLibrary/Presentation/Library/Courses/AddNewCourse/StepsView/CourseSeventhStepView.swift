//
//  CourseSeventhStepView.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 19/09/2024.
//

import Foundation
import EMLECore
import SwiftUI

struct CourseSeventhStepView: View {
    @ObservedObject var viewModel: AddNewCourseViewModel

    var body: some View {
        VStack(alignment: .leading) {
            StepHeaderView(title: viewModel.addCourseSteps.headerTitle, subTitle: viewModel.addCourseSteps.headerSubtitle)
            Group {
                let imageToShow = viewModel.didSelectImage ? Image(uiImage: viewModel.courseImage.image) : Image.uploadImage
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
            
            PrimaryButton(title: LibraryStrings.finishAndPublish.localized) { viewModel.finishAndPublishTapped() }
                .clipShape(Capsule())
                .padding()
            
            PrimaryButton(title: LibraryStrings.saveAsDraft.localized) { viewModel.addAntherTargetTapped() }
                .disabled(!viewModel.canAddNewTarget)
                .clipShape(Capsule())
                .padding()
        }
        .sheet(isPresented: $viewModel.imagePickerPresenting) {
            ImagePicker(pickerImage: $viewModel.courseImage, sourceType: viewModel.sourceType)
        }
        .padding(.xSm)
    }
}
