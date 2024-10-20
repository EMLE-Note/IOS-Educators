//
//  ChildernFolderView.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 20/08/2024.
//

import SwiftUI
import EMLECore

struct ChildernFolderView: View {
    
    @StateObject var viewModel: ChildernFolderViewModel
    
    init(folderId: Int, coordinator: ChildernFolderViewCoordinating) {
        _viewModel = StateObject(wrappedValue: ChildernFolderViewModel(folderId: folderId, coordinator: coordinator))
    }
    
    var body: some View {
        MainView(viewModel: viewModel) {
            contentView
                .customContentPadding(.horizontal, defaultHPadding)
                .customContentPadding(.vertical, .md)
                .redacted(viewModel.childernLoadingState)
                .withShimmerOverlay()
            
            
            Spacer()
        }
        .customSheet(isPresented: $viewModel.isOptianFolderViewPresented,
                     height: 150,
                     detents: [.medium],
                     content: { getSheetView { optionalContentView() }
        })
        .withCustomDialog(
            isPresented: $viewModel.isDeleteDialogViewPresented,
            image: .aboutEMLE,
            title: viewModel.dialogDeleteFolderModel.title,
            message: viewModel.dialogDeleteFolderModel.title,
            yesButtonTitle: viewModel.dialogDeleteFolderModel.title,
            yesButtonAction: viewModel.deleteFolder,
            noButtonTitle: viewModel.dialogDeleteFolderModel.title
        )
    }
}

#Preview {
    ChildernFolderView(folderId: -1, coordinator: ChildernFolderViewCoordinator(navigationController: UINavigationController(), tabBarController: MainTabBarController()))
}

// MARK: - Navigation View -

extension ChildernFolderView {
    private var navigationBar: some View {
        HStack {
            CustomNavigationBar.Checkout(title: viewModel.parentFolder?.name ?? "")
                .padding(.bottom, .xSm)
                .padding(.horizontal, defaultHPadding)
            
            Spacer()
            
            Image.edit
                .resizable()
                .frame(width: 28, height: 28)
                .padding(.bottom, .xSm)
                .padding(.horizontal, .md)
                .onTapGesture {
                    viewModel.editCourseTapped()
                }
            
        }
        .customBackground(.container)
    }
}

// MARK: - Content Body View

extension ChildernFolderView {
    private var contentView: some View {
        VStack {
            if !viewModel.displayedFolders.isEmpty {
                content
                Spacer()
                
                if viewModel.isParentFolder {
                    parentButton
                } else {
                    lessonButton
                }
            } else {
                navigationBar
                Spacer()
                emptyContentView
                Spacer()
            }
        }
    }
}

extension ChildernFolderView {
    private var content: some View {
        FoldersView(parentFolder: viewModel.parentFolder,
                    backAction: viewModel.onFolderBackClick,
                    editAction: viewModel.editCourseTapped,
                    folders: viewModel.displayedFolders,
                    selectAction: viewModel.onFolderSelect,
                    optianAction: viewModel.onClickedOptianContent)
    }
}

// MARK: - Content View -

extension ChildernFolderView {
    private func contentCardView(folder: Child) -> some View {
        HStack(alignment: .center, spacing: .xSm) {
            HStack(alignment: .center, spacing: .xSm) {
                VStack {
                    Image.folderIcon
                        .customCornerRadii(.xxSm, corners: .allCorners)
                        .frame(width: 57, height: 57)
                }
                .padding(.xSm)

                VStack(alignment: .leading, spacing: .xSm) {
                    Text(folder.name)
                        .customStyle(.subheadline, .onSurface)
                    if folder.type == 1 {
                        Text("\(folder.booksCount) Book, \(folder.quizCount) Quiz")
                    } else {
                        EmptyView()
                    }
                }
                .padding(.xxSm)

                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack(alignment: .center, spacing: .xSm) {
                privacyView(isPublic: folder.isVisible)
                
                Image.optianCourse
                    .resizable()
                    .frame(width: 16, height: 16)
                    
            }
            .padding(.xSm)
        }
        .redacted(viewModel.childernLoadingState)
        .withShimmerOverlay()
        .customBackground(.onPrimary)
        .withCardShadow(backgroundColor: .onSurface, cornerRadius: .sm)
        .padding(.horizontal, .xSm)
        .onTapGesture {
            viewModel.onClickedShowChildernFolder(folderId: folder.id)
        }
    }
    
    private func privacyView(isPublic: Bool) -> some View {
        Group {
            if !isPublic {
                Image.eyeOff
                    .resizable()
                    .frame(width: 30, height: 30)
            } else {
                EmptyView()
            }
        }
    }
    
    func getSheetView<Content: View>(@ViewBuilder content: @escaping () -> Content) -> some View {
        VStack {
            Spacer()

            VStack(spacing: .xSm) {
                content()
            }
            .padding(.horizontal, defaultHPadding)
            .padding(.top, .sm)
            .padding(.bottom, .xxxBig)
            .customBackground(.container)
            .customCornerRadii(.sm, corners: [.topLeft, .topRight])
        }
        .ignoresSafeArea()
    }
}

// MARK: - Empty Content View -

extension ChildernFolderView {
    private var emptyContentView: some View {
        VStack(alignment: .center, spacing: .xSm) {
            Spacer()
            Image.emptyContent
                .resizable()
                .frame(width: 160, height: 170)
            Text(LibraryStrings.startBuildingCourse.localized)
                .customStyle(.heading1, .onSurface)
            
            VStack(alignment: .center, spacing: .xSm) {
                parentButton
                lessonButton
            }
            Spacer()
        }
        .padding()
    }
}

// MARK: - Optional View -

extension ChildernFolderView {
    private func optionalContentView() -> some View {
        VStack(alignment: .leading, spacing: .md) {
            ForEach(viewModel.contentOptions, id: \.self) { option in
                optionView(for: option)
                    .onTapGesture {
                        viewModel.handleAction(for: option)
                    }
            }
        }
        .padding(.horizontal, .xSm)
        .customBackground(.container)
    }
    
    private func optionView(for option: OptionType) -> some View {
        OptionView(
            icon: option.icon,
            title: option.title,
            description: option.description
        )
    }
}

// MARK: - Parent Button -

extension ChildernFolderView {
    private var parentButton: some View {
        PrimaryButton(title: LibraryStrings.createParentFolder.localized, action: viewModel.onClickedCreateParentFolder)
            .clipShape(Capsule())
            .padding()
    }
}

extension ChildernFolderView {
    private var lessonButton: some View {
        PrimaryButton(title: LibraryStrings.createLessonFolder.localized,
                      action: viewModel.onClickedCreateLessonFolder,
                      textColor: .onSurface,
                      backgroundColor: .onPrimary)
        .clipShape(Capsule())
        .padding(.xxSm)
    }
}
