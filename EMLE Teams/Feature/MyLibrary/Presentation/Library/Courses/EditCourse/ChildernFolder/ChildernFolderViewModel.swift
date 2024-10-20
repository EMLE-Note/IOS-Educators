//
//  ChildernFolderViewModel.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 20/08/2024.
//

import Foundation
import EMLECore
import Combine
import SwiftUI

typealias FolderDelegate = GenericAction<Folder>
typealias FolderMaterialDelegate = GenericAction<FolderMaterial>

class ChildernFolderViewModel: MainViewModel {
    let coordinator: ChildernFolderViewCoordinating
    init(folderId: Int, coordinator: ChildernFolderViewCoordinating) {
        self.folderId = folderId
        self.coordinator = coordinator
    }
    
    var isParentFolder: Bool = false
    var isTabBarVisible: Bool { false }
    let folderId: Int
    var selectedFolderId: Int? = nil
    let dialogDeleteFolderModel = CustomDialogModelConfigurator.configureModel(for: .deleteFolder)
    var cancellables = Set<AnyCancellable>()
    
    @Inject var childernFolderUseCase: ChildernFolderUseCase
    @Inject var contentDataUseCase: ContentDataUseCase
    
    @Published var parentFolder: Folder? = nil
    @Published var folders: [Folder] = []
    @Published var displayedFolders: [Folder] = []
    @Published var childernLoadingState: LoadingState = .loaded
    @Published var childers: ChildrenFolder?
    @Published var isOptianFolderViewPresented = false
    @Published var isDeleteDialogViewPresented = false
    @Published var contentOptions: [OptionType] = []
    @Published var isShowContentEmptyView: Bool = false
}

extension ChildernFolderViewModel {
    func onAppear() {
        fetchChildernFolder(folderId: folderId)
    }
    
    func editCourseTapped() {
        if parentFolder?.level == .first {
            coordinator.goToEditParentFolder(folderId: folderId)
        } else {
            coordinator.goToEditParentFolder(folderId: parentFolder?.parent?.id ?? -1 )
        }
    }
    
    func onClickedCreateParentFolder() {
        
    }
    
    func onClickedOptianContent(folder: Folder) {
        withOptionalAnimation {
            isOptianFolderViewPresented = true
        }
        selectedFolderId = folder.folderId
        contentOptions = [
            .hideFolder(folderId: folder.folderId, isVisible: folder.isVisible),
            .deletePermanently(folderId: folderId)
        ]
    }
    
    func onClickedCreateLessonFolder() {
        
    }
    
    func deletePermanentlyTapped(folderId: Int) {
        withAnimation {
            isOptianFolderViewPresented = false
            isDeleteDialogViewPresented = true
        }
    }
    
    func deleteFolder() {
        withAnimation {
            isDeleteDialogViewPresented = false
        }
        guard let selectedFolderId = selectedFolderId else { return }
        deleteFolder(folderId: selectedFolderId)
    }
    
    func onClickedShowChildernFolder(folderId: Int) {
        coordinator.goToSubChildernFolder(folderId: folderId)
    }
    
    func onFolderBackClick() {
        
        if let parent = parentFolder?.parent {
            if let parentFolderIndex = folders.firstIndex(where: { $0.folderId == parent.id }) {
                self.parentFolder = folders[parentFolderIndex]
                self.displayedFolders = self.parentFolder?.children ?? []
            } else {
                print("No parent folder found for current folder with ID: \(parent.id)")
            }
        } else {
            self.parentFolder = nil
            coordinator.popView()
        }
        displayedFolders = parentFolder?.children ?? folders
        
    }
    
    func onFolderSelect(folder: Folder) {
        print("onFolderSelect")
        
        switch folder.type {
        case .parent:
            onParentFolderSelect(folder: folder)
            
        case .lessons:
            coordinator.goToLessonFolderDetails(folderId: folder.folderId)
        }
    }
}

extension ChildernFolderViewModel {
    private func onParentFolderSelect(folder: Folder) {
        parentFolder = folder
        
        if !folder.children.isEmpty {
            self.displayedFolders = folder.children
        }
        else {
            fetchChildernFolder(folderId: folder.folderId)
        }
    }
}

// MARK: - ViewModel Handling

extension ChildernFolderViewModel {
    func handleAction(for option: OptionType) {
        switch option {
        case .hideFolder(let folderId, let isVisible):
            toggleHiddenFolder(folderId: folderId, isVisible: isVisible)
        case .deletePermanently(let folderId):
            deletePermanentlyTapped(folderId: folderId)
        case .editSecurity: return
        case .toggleActivation: return
        }
    }
    
    private func toggleHiddenFolder(folderId: Int, isVisible: Bool) {
        withOptionalAnimation {
            isOptianFolderViewPresented = false
        }
        if isVisible {
            updateFolder(isVisible: 0, folderId: folderId)
        } else {
            updateFolder(isVisible: 1, folderId: folderId)
        }
    }
}

    
// MARK: - get Content requests -

extension ChildernFolderViewModel {
    func fetchChildernFolder(folderId: Int) {
        do {
            childernLoadingState = .loading
            displayedFolders = .placeholder
            
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
            displayedFolders = []
            return
        }
        
        if folderData.type == .parent && folderData.parent == nil {
            self.isParentFolder = true
        } else {
            self.isParentFolder = false
        }
        
        if folderData.parent == nil {
            if folders.isEmpty {
                folders.append(folderData)
            } else {
                folders[0] = folderData
            }
        } else {
            updateOrAppendFolder(folderData)
        }
        
        self.parentFolder = folderData
        self.displayedFolders = folderData.children
    }

    private func updateOrAppendFolder(_ folderData: Folder) {
        var updated = false
        
        for i in 0..<folders.count {
            if let index = folders[i].children.firstIndex(where: { $0.folderId == folderData.folderId }) {
                folders[i].children[index] = folderData
                updated = true
                break
            }
        }
        
        if !updated, let parentId = folderData.parent?.id {
            appendToParentFolder(folderData, parentId: parentId)
        }
    }

    private func appendToParentFolder(_ folderData: Folder, parentId: Int) {
        if let parentIndex = folders.firstIndex(where: { $0.folderId == parentId }) {
            folders[parentIndex].children.append(folderData)
        } else {
            showErrorToast(message: "Parent folder not found for folder ID: \(folderData.folderId)")
        }
    }
}

// MARK: - Update Folder -

extension ChildernFolderViewModel {
    func updateFolder(isVisible: Int, folderId: Int) {
        do {
            let body: UpdateFolderParameter = UpdateFolderParameter(folderId: folderId, isVisible: isVisible)
            
            try contentDataUseCase.updateFolder(folderId: folderId, params: body)
                .sink(receiveCompletion: handleSecretriesCompletion,
                      receiveValue: handleUpdateFolderRequestsResult)
                .store(in: &cancellables)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func handleUpdateFolderRequestsResult(contentRequests: DomainWrapper<ChildrenFolder>) {
        childernLoadingState = .loaded
        
        if contentRequests.isSuccess {
            fetchChildernFolder(folderId: parentFolder?.folderId ?? 0)
        } else {
            print(contentRequests.message)
            showErrorToast(message: contentRequests.message)
        }
    }
}

// MARK: - Update Folder -

extension ChildernFolderViewModel {
    func deleteFolder(folderId: Int) {
        do {
            let filters: DeleteFolderFilterRequest = .empty
            print(filters)
            let params = DeleteFolderDTO(filters: filters)
            
            try contentDataUseCase.deleteFolder(folderId: folderId, params: params)
                .sink(receiveCompletion: handleSecretriesCompletion,
                      receiveValue: handleDeleteFolderRequestsResult)
                .store(in: &cancellables)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func handleDeleteFolderRequestsResult(contentRequests: DomainWrapper<DeleteFolderResponse>) {
        childernLoadingState = .loaded
        
        if contentRequests.isSuccess {
            showSuccessToast(message: contentRequests.message)
            fetchChildernFolder(folderId: folderId)
        } else {
            print(contentRequests.message)
            showErrorToast(message: contentRequests.message)
        }
    }
}
