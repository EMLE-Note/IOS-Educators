//
//  LessonFolderDetailsViewModel.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 04/10/2024.
//

import Foundation
import EMLECore
import Combine
import SwiftUI

typealias FoldersMaterialDelegate = GenericAction<FolderMaterial>

class LessonFolderDetailsViewModel: MainViewModel {
    
    let coordinator: LessonFolderDetailsCoordinating
    init(folderId: Int, coordinator: LessonFolderDetailsCoordinating) {
        self.folderId = folderId
        self.coordinator = coordinator
    }
    
    let folderId: Int
    var isTabBarVisible: Bool { false }
    var selectedFolderId: Int? = nil
    var cancellables = Set<AnyCancellable>()
    
    @Published var isOptianFolderViewPresented = false
    @Published var folderMaterial: [FolderMaterial] = []
    @Published var folder: Folder = .placeholder
    @Published var childernLoadingState: LoadingState = .loaded
    @Published var contentOptions: [OptionType] = []
    
    @Inject var childernFolderUseCase: ChildernFolderUseCase
}

extension LessonFolderDetailsViewModel {
    func onAppear() {
        fetchMaterialFolder(folderId: folderId)
    }
    
    func editCourseTapped() {
        coordinator.goToEditParentFolder(folderId: folderId)
    }
    
    func onClickedOptianContent(folder: FolderMaterial) {
        withOptionalAnimation {
            isOptianFolderViewPresented = true
        }
        selectedFolderId = folderId
        contentOptions = [
            .hideFolder(folderId: folderId, isVisible: true),
            .deletePermanently(folderId: folderId)
        ]
    }
    
    func uploadVideoTapped() {
        coordinator.goToUploadVideoView(folderId: folderId)
    }
    
    func uploadQBankTapped() {
        print("Video button tapped")
    }
    
    func uploadBookTapped() {
        print("Map button tapped")
    }
}

extension LessonFolderDetailsViewModel {
    func handleAction(for option: OptionType) {
        switch option {
        case .hideFolder(let folderId, let isVisible):
            return
        case .deletePermanently(let folderId):
            return
        case .editSecurity: return
        case .toggleActivation: return
        }
    }
}

// MARK: - get Content requests -

extension LessonFolderDetailsViewModel {
    func fetchMaterialFolder(folderId: Int) {
        do {
            childernLoadingState = .loading
            folderMaterial = .placeholder
            
            let filters: GetContentFilterRequest = .empty
            print(filters)
            
            try childernFolderUseCase.execute(folderId: folderId)
                .sink(receiveCompletion: handleSecretriesCompletion,
                      receiveValue: handleFolder)
                .store(in: &cancellables)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func handleSecretriesCompletion(completion: Subscribers.Completion<UseCaseError>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print("Error: \(error)")
            showErrorToast(error: error)
            childernLoadingState = .failed
        }
    }
    
    func handleFolder(folder: DomainWrapper<Folder>) {
        childernLoadingState = .loaded
        
        guard folder.isSuccess, let folderData = folder.data else {
            let errorMessage = folder.message
            showErrorToast(message: "Error message\n\(errorMessage)")
            return
        }
        
        self.folder = folderData
        self.folderMaterial = folderData.materials
    }
}
