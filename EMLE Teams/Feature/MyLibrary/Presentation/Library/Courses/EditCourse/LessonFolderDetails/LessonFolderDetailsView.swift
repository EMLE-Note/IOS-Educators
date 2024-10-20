//
//  LessonFolderDetailsView.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 04/10/2024.
//

import SwiftUI
import EMLECore

struct LessonFolderDetailsView: View {
    
    @StateObject var viewModel: LessonFolderDetailsViewModel
    
    init(folderId: Int, coordinator: LessonFolderDetailsCoordinating) {
        _viewModel = StateObject(wrappedValue: LessonFolderDetailsViewModel(folderId: folderId, coordinator: coordinator))
    }
    
    var body: some View {
        MainView(viewModel: viewModel) {
            navigationBar
            contentView
                .customContentPadding(.horizontal, defaultHPadding)
                .customContentPadding(.vertical, .md)
                .redacted(viewModel.childernLoadingState)
                .withShimmerOverlay()
            
            Spacer()
        }
        .overlay( fabMenu , alignment: .bottomTrailing )
        .customSheet(isPresented: $viewModel.isOptianFolderViewPresented,
                     height: 150,
                     detents: [.medium],
                     content: { getSheetView { optionalContentView() }
        })
    }
}

#Preview {
    LessonFolderDetailsView(folderId: -1, coordinator: LessonFolderDetailsCoordinator(navigationController: UINavigationController(), tabBarController: MainTabBarController()))
}

// MARK: - Content Body View

extension LessonFolderDetailsView {
    private var contentView: some View {
        VStack {
            if !viewModel.folderMaterial.isEmpty {
                content
                Spacer()
            }
        }
    }
}

extension LessonFolderDetailsView {
    private var fabMenu: some View {
        FABMenu(buttons: [
            (Image.quizIcon, viewModel.uploadQBankTapped),
            (Image.bookIcon, viewModel.uploadBookTapped),
            (Image.videoIcon, viewModel.uploadVideoTapped),
        ])
        .padding([.trailing, .bottom], 30)
    }
}

// MARK: - Navigation View -

extension LessonFolderDetailsView {
    private var navigationBar: some View {
        HStack {
            CustomNavigationBar.Checkout(title: viewModel
                .folder.name)
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

extension LessonFolderDetailsView {
    private var content: some View {
        MaterialView(materialFolder: viewModel.folderMaterial, optianAction: viewModel.onClickedOptianContent)
            .padding(.xSm)
    }
}


// MARK: - Optional View -

extension LessonFolderDetailsView {
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
