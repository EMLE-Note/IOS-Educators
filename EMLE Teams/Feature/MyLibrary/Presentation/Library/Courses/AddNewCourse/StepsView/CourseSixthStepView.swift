//
//  CourseSixthStepView.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 19/09/2024.
//

import Foundation
import EMLECore
import SwiftUI

struct CourseSixthStepView: View {
    @ObservedObject var viewModel: AddNewCourseViewModel

    var body: some View {
        VStack(alignment: .leading) {
            StepHeaderView(title: viewModel.addCourseSteps.headerTitle, subTitle: viewModel.addCourseSteps.headerSubtitle)
            
            NoIndicatorsScrollView {
                learnerSignatureView
                fingerprintView
                faceRecognitionView
                studentNameAudioView
                preventScreenRecordView
                headphoneSecurityView
                nationalIDVerificationView
                Spacer()
            }
            .padding(.horizontal, .xxSm)
            .padding(.vertical, .xSm)

        }
        .withDialog(
            isPresented: $viewModel.isPressentedDialog,
            title: viewModel.selectedSecurityOption?.dialogTitle ?? "",
            message: viewModel.selectedSecurityOption?.dialogMessage ?? ""
        )
        .customSheet(isPresented: $viewModel.isPresentCustomSheetView,
                     height: 300,
                     detents: [.medium, .large]) {
            VStack {
                Spacer()
                if let action = viewModel.currentAction {
                    switch action {
                    case .fontWeight:
                        CustomPickerItems(
                            singleSelectedItem: $viewModel.selectedFontWeight,
                            items: viewModel.fontWeights,
                            selectedColor: .primary,
                            areItemsEqual: { $0 == $1 }
                        ) {  viewModel.selectFontWeight(viewModel.selectedFontWeight) }
                            .padding()
                    case .fontSize:
                        CustomPickerItems(
                            singleSelectedItem: $viewModel.selectedFontSize,
                            items: viewModel.fontSizes,
                            selectedColor: .neutral,
                            areItemsEqual: { $0 == $1 }
                        ) {  viewModel.selectFontSize(viewModel.selectedFontSize) }
                        .padding()
                    case .verifyIdentity:
                        CustomPickerItems(
                            singleSelectedItem: $viewModel.selectedFingerPrintTimeInterval,
                            items: viewModel.timeIntervals,
                            selectedColor: .neutral,
                            areItemsEqual: { $0 == $1 }
                        ) {
                            viewModel.selectFingerPrintDurationOption(viewModel.selectedFingerPrintTimeInterval)
                        }
                        .padding()
                    case .playSound:
                        CustomPickerItems(
                            singleSelectedItem: $viewModel.selectedPlaySoundTimeInterval,
                            items: viewModel.timeIntervals,
                            selectedColor: .neutral,
                            areItemsEqual: { $0 == $1 }
                        ) {
                            viewModel.selectPlaySoundDurationOption(viewModel.selectedPlaySoundTimeInterval)
                        }
                        .padding()
                    }
                }
                Spacer()
            }
            .background(Color.white)
            .ignoresSafeArea()
        }
    }
}

// MARK: - Learner Signature View -

extension CourseSixthStepView {
    private var learnerSignatureView: some View {
        SecurityOptionView(
            title: LibraryStrings.learnerSignature.localized,
            isSelected: $viewModel.isLearnerSignatureSelected,
            optionType: .learnerSignature,
            customLayerViews: [
                CustomLayerView(
                    title: LibraryStrings.fontSize.localized,
                    placeholder: "16",
                    value: $viewModel.fontSize,
                    onClick: viewModel.onClickedFontSize
                ),
                CustomLayerView(
                    title: LibraryStrings.fontWeight.localized,
                    placeholder: "Regular",
                    value: $viewModel.fontweight,
                    onClick: viewModel.onClickedFontWeight
                )
            ],
            onInfoTap: {
                viewModel.presentDialog(for: .learnerSignature)
            }
        )
    }
}

// MARK: - Fingerprint View -

extension CourseSixthStepView {
    private var fingerprintView: some View {
        SecurityOptionView(
            title: LibraryStrings.fingerprint.localized,
            isSelected: $viewModel.isFingerprintSelected,
            optionType: .fingerprint,
            customLayerViews: [
                CustomLayerView(
                    title: LibraryStrings.verifyIdentityEvery.localized,
                    placeholder: "20 min",
                    value: $viewModel.fingerPrint,
                    onClick: viewModel.onClickedVerifyIdentity
                )
            ],
            onInfoTap: {
                viewModel.presentDialog(for: .fingerprint)
            }
        )
    }
}

// MARK: - Face Recognition View -

extension CourseSixthStepView {
    private var faceRecognitionView: some View {
        SecurityOptionView(
            title: LibraryStrings.faceRecognition.localized,
            isSelected: $viewModel.isFaceRecognitionSelected,
            optionType: .faceRecognition,
            onInfoTap: {
                viewModel.presentDialog(for: .faceRecognition)
            }
        )
    }
}

// MARK: - Student Name Audio View -

extension CourseSixthStepView {
    private var studentNameAudioView: some View {
        SecurityOptionView(
            title: LibraryStrings.studentNameAudio.localized,
            isSelected: $viewModel.isStudentNameAudioSelected,
            optionType: .studentNameAudio,
            customLayerViews: [
                CustomLayerView(
                    title: LibraryStrings.playSound.localized,
                    placeholder: "20 min",
                    value: $viewModel.playSound,
                    onClick: viewModel.onClickedPlaySound
                )
            ],
            onInfoTap: {
                viewModel.presentDialog(for: .studentNameAudio)
            }
        )
    }
}

// MARK: - Prevent Screen Record View -

extension CourseSixthStepView {
    private var preventScreenRecordView: some View {
        SecurityOptionView(
            title: LibraryStrings.preventScreen.localized,
            isSelected: $viewModel.isPreventScreenRecordSelected,
            optionType: .preventScreenRecord,
            onInfoTap: {
                viewModel.presentDialog(for: .preventScreenRecord)
            },
            customBackground: .containerBlack40
        )
        .disabled(true)
    }
}

// MARK: - Headphone Security View -

extension CourseSixthStepView {
    private var headphoneSecurityView: some View {
        SecurityOptionView(
            title: LibraryStrings.headphoneSecurity.localized,
            isSelected: $viewModel.isHeadphoneSecuritySelected,
            optionType: .headphoneSecurity,
            onInfoTap: {
                viewModel.presentDialog(for: .headphoneSecurity)
            }
        )
    }
}

// MARK: - National ID Verification View -

extension CourseSixthStepView {
    private var nationalIDVerificationView: some View {
        SecurityOptionView(
            title: LibraryStrings.nationalIdVerification.localized,
            isSelected: $viewModel.isNationalIDVerificationSelected,
            optionType: .nationalIDVerification,
            onInfoTap: {
                viewModel.presentDialog(for: .nationalIDVerification)
            },
            customBackground: .containerBlack40
        )
        .disabled(true)
    }
}
