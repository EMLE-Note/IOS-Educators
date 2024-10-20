//
//  ProtectionLayerView.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 15/08/2024.
//

import SwiftUI
import EMLECore

struct ProtectionLayerView: View {
    
    @StateObject var viewModel: ProtectionLayerViewModel
    
    init(courseId: Int?, securityType: SecurityType, security: Security?, coordinator: ProtectionLayerViewCoordinating) {
        _viewModel = StateObject(wrappedValue: ProtectionLayerViewModel(courseId: courseId, securityType: securityType, security: security, coordinator: coordinator))
    }
    
    var body: some View {
        
        MainView(viewModel: viewModel) {
            navigationBar
            NoIndicatorsScrollView {
                learnerSignatureView
                fingerprintView
                faceRecognitionView
                studentNameAudioView
                preventScreenRecordView
                notifcationSecurityView
                headphoneSecurityView
                nationalIDVerificationView
                Spacer()
            }
            .padding(.vertical, .xxSm)
            
            Spacer()
            customButtons
        }
        .withDialog(
            isPresented: $viewModel.isPressentedDialog,
            title: viewModel.selectedSecurityOption?.dialogTitle ?? "Default Title",
            message: viewModel.selectedSecurityOption?.dialogMessage ?? "Default Message"
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
        }
    }
}

#Preview {
    ProtectionLayerView(courseId: -1, securityType: .course, security: nil, coordinator: ProtectionLayerViewCoordinator(navigationController: UINavigationController(), tabBarController: MainTabBarController()))
}

// MARK: - Navigation View -

extension ProtectionLayerView {
    private var navigationBar: some View {
        HStack {
            CustomNavigationBar.Checkout(title: LibraryStrings.protectionLayer.localized)
                .padding(.bottom, .xxSm)
                .customBackground(.container)
                .padding(.horizontal, defaultHPadding)
        }
        .customBackground(.container)
        .padding(.bottom, .md)
    }
}

// MARK: - Learner Signature View -

extension ProtectionLayerView {
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

extension ProtectionLayerView {
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

extension ProtectionLayerView {
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

extension ProtectionLayerView {
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

extension ProtectionLayerView {
    private var preventScreenRecordView: some View {
        SecurityOptionView(
            title: LibraryStrings.preventScreen.localized,
            isSelected: $viewModel.isPreventScreenRecordSelected,
            optionType: .preventScreenRecord,
            onInfoTap: {
                viewModel.presentDialog(for: .preventScreenRecord)
            }
        )
    }
}

// MARK: - Notification Security View -

extension ProtectionLayerView {
    private var notifcationSecurityView: some View {
        SecurityOptionView(
            title: LibraryStrings.notificationSecurity.localized,
            isSelected: $viewModel.isNotificationSecuritySelected,
            optionType: .notificationSecurity,
            onInfoTap: {
                viewModel.presentDialog(for: .notificationSecurity)
            },
            customBackground: .containerBlack40
        )
        .disabled(true)
    }
}

// MARK: - Headphone Security View -

extension ProtectionLayerView {
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

extension ProtectionLayerView {
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

// MARK: - Apply Button -

extension ProtectionLayerView {
    private var customButtons: some View {
        VStack {
            PrimaryButton(title: LibraryStrings.applyChanges.localized) { viewModel.onApplyChangeClick() }
                .clipShape(Capsule())
            
            TextButton(title: LibraryStrings.discardChanges.localized) { viewModel.onDiscardChangeClick() }
        }
        .padding(.horizontal, .md)
    }
}
