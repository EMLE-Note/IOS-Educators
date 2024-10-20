//
//  QBankSettingView.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 25/09/2024.
//

import SwiftUI
import EMLECore

struct QBankSettingView: View {
    @StateObject var viewModel: QBankSettingViewModel
    
    init(qbankId: Int, coordinator: QBankSettingCoordinating) {
        _viewModel = StateObject(wrappedValue: QBankSettingViewModel(coordinator: coordinator, qbankId: qbankId))
    }
    
    var body: some View {
        MainView(viewModel: viewModel) {
            navigationBar
            NoIndicatorsScrollView {
                changeImageView
                qbankIdView
                qbankTitleView
                qbankPriceView
                qbankOverView
                Spacer()
            }
            customButtons
        }
        .sheet(isPresented: $viewModel.imagePickerPresenting, content: {
            ImagePicker(pickerImage: $viewModel.qbankImage, sourceType: viewModel.sourceType)
        })
    }
    
}

#Preview {
    QBankSettingView(qbankId: -1, coordinator: QBankSettingCoordinator(navigationController: UINavigationController(), tabBarController: MainTabBarController()))
}

// MARK: - Navigation View -

extension QBankSettingView {
    private var navigationBar: some View {
        HStack {
            CustomNavigationBar.Checkout(title: LibraryStrings.qbankTitle.localized)
                .padding(.bottom, .xxSm)
                .customBackground(.container)
                .padding(.horizontal, defaultHPadding)
        }
    }
}

// MARK: - Change Image -

extension QBankSettingView {
    private var changeImageView: some View {
        VStack(alignment: .leading) {
            Text(LibraryStrings.qbankTitle.localized)
                .customStyle(.subheadline, .onSurface)
            
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
        }
        .padding(.horizontal, .md)
        .padding(.vertical, .md)
    }
}

// MARK: - Course ID -

extension QBankSettingView {
    private var qbankIdView: some View {
        VStack(alignment: .leading) {
            CustomTextField(title: LibraryStrings.qbankId.localized,
                            placeholder: LibraryStrings.courseIdPH.localized,
                            value: $viewModel.qbankID,
                            borderStateColor: .neutral,
                            disable: true)
            .opacity(0.7)
            .padding(.horizontal, .md)
        }
    }
}

// MARK: - Course Title -

extension QBankSettingView {
    private var qbankTitleView: some View {
        VStack(alignment: .leading) {
            CustomTextField(title: LibraryStrings.qbankTitle.localized,
                            placeholder: LibraryStrings.qbankTitlePH.localized,
                            value: $viewModel.qbankTitle,
                            borderStateColor: .neutral)
            .padding(.horizontal, .md)
            .padding(.vertical, .md)
        }
    }
}

// MARK: - Course Price -

extension QBankSettingView {
    private var qbankPriceView: some View {
        VStack(alignment: .leading) {
            CustomTextField(title: LibraryStrings.qbankPrice.localized,
                            placeholder: LibraryStrings.qbankPricePH.localized,
                            value: $viewModel.qbankPrice,
                            borderStateColor: .neutral)
            .keyboardType(.numberPad)
            .padding(.horizontal, .md)
        }
    }
}

// MARK: - Course OverView -

extension QBankSettingView {
    private var qbankOverView: some View {
        VStack(alignment: .leading) {
            Text(LibraryStrings.qbankOverview.localized)
                .customStyle(.subheadline, .onSurface)
            
            CustomTextView(text: $viewModel.qbankOverview,
                           placeholder: LibraryStrings.qbankOverviewPH.localized)
        }
        .padding(.horizontal, .md)
        .padding(.vertical, .md)
    }
}


// MARK: - Apply Button -

extension QBankSettingView {
    private var customButtons: some View {
        VStack {
            PrimaryButton(title: LibraryStrings.applyChanges.localized) { viewModel.onApplyChangeClick() }
                .disabled(!viewModel.isApplyButtonEnabled)
                .clipShape(Capsule())
            
            TextButton(title: LibraryStrings.discardChanges.localized) { viewModel.onDiscardChangeClick() }
            
            
        }
        .padding(.horizontal, .md)
    }
}
