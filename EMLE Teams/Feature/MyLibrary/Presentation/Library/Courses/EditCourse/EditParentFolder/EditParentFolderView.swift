//
//  EditParentFolderView.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 21/08/2024.
//

import SwiftUI
import EMLECore

struct EditParentFolderView: View {
    
    @StateObject var viewModel: EditParentFolderViewModel
    
    init(folderId: Int, coordinator: EditParentFolderCoordinating) {
        _viewModel = StateObject(wrappedValue: EditParentFolderViewModel(folderId: folderId, coordinator: coordinator))
    }
    
    var body: some View {
        MainView(viewModel: viewModel) {
            navigationBar
            parentFolderName
            Spacer()
            customButtons
        }
        .withCustomDialog(
            isPresented: $viewModel.isDeleteDialogViewPresented,
            image: .placeholder,
            title: viewModel.dialogDeleteFolderModel.title,
            message: viewModel.dialogDeleteFolderModel.title,
            yesButtonTitle: viewModel.dialogDeleteFolderModel.title,
            yesButtonAction: viewModel.deleteFolder,
            noButtonTitle: viewModel.dialogDeleteFolderModel.title
        )
    }
}

#Preview {
    EditParentFolderView(folderId: -1, coordinator: EditParentFolderCoordinator(navigationController: UINavigationController(), tabBarController: MainTabBarController()))
}

// MARK: - Navigation View -

extension EditParentFolderView {
    private var navigationBar: some View {
        HStack {
            CustomNavigationBar.Checkout(title: viewModel.childers?.name ?? "")
                .padding(.bottom, .xSm)
                .padding(.horizontal, defaultHPadding)
            
            Spacer()
            
            Button(action: {
                viewModel.deleteCourseTapped()
            }) {
                Text(LibraryStrings.delete.localized)
                    .customFont(.subheadline)
            }
            .padding(.horizontal, .md)
            .padding(.vertical, .xSm)
            .customBackground(.white)
            .customForeground(.error)
            .customCornerRadii(.xxSm, corners: .allCorners)
            .overlay(
                RoundedRectangle(cornerRadius: .xxSm)
                    .stroke(Color.red, lineWidth: 1)
            )
            .padding(.horizontal, .md)
            
        }
        .customBackground(.container)
        .padding(.bottom, .sm)
    }
}

// MARK: - Custom Text Filed -

extension EditParentFolderView {
    private var parentFolderName: some View {
        VStack(alignment: .leading) {
            CustomTextField(title: LibraryStrings.parentFolderName.localized,
                            placeholder: LibraryStrings.folderName.localized,
                            value: $viewModel.folderName,
                            borderStateColor: .neutral)
            .padding(.horizontal, .md)
        }
    }
}

// MARK: - Apply Button -

extension EditParentFolderView {
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
