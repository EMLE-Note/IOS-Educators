//
//  EditParentFolderViewModel.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 21/08/2024.
//

import Foundation
import EMLECore
import Combine
import SwiftUI

class EditParentFolderViewModel: MainViewModel {
    let coordinator: EditParentFolderCoordinating
    init(folderId: Int, coordinator: EditParentFolderCoordinating) {
        self.folderId = folderId
        self.coordinator = coordinator
    }
    
    var isTabBarVisible: Bool { false }
    let folderId: Int
    var cancellables = Set<AnyCancellable>()
    var isApplyButtonEnabled: Bool {
        !folderName.isEmpty
    }
    let dialogDeleteFolderModel = CustomDialogModelConfigurator.configureModel(for: .deleteFolder)
    
    @Inject var contentDataUseCase: ContentDataUseCase
    @Inject var childernFolderUseCase: ChildernFolderUseCase
    
    @Published var childers: Folder?
    @Published var childernLoadingState: LoadingState = .loaded
    @Published var folderName = ""
    @Published var isDeleteDialogViewPresented = false
}

extension EditParentFolderViewModel {
    func onAppear() {
        fetchChildernFolder(folderId: folderId)
    }
    
    func deleteCourseTapped() {
        withAnimation {
            isDeleteDialogViewPresented = true
        }
    }
    
    func onApplyChangeClick() {
        updateFolder(folderName: folderName, folderId: folderId)
    }
    
    func onDiscardChangeClick() {
        
    }
    
    func deleteFolder() {
        withAnimation {
            isDeleteDialogViewPresented = false
        }
        if let id = childers?.folderId {
            deleteFolder(folderId: id)
        }
    }
}

// MARK: - Update Folder -

extension EditParentFolderViewModel {
    func updateFolder(folderName: String, folderId: Int) {
        do {
            let body: UpdateFolderParameter = UpdateFolderParameter(folderId: folderId, name: folderName)
            
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
            showSuccessToast(message: contentRequests.message)
            coordinator.popView()
        } else {
            print(contentRequests.message)
            showErrorToast(message: contentRequests.message)
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
}

// MARK: - get Content requests -

extension EditParentFolderViewModel {
    func fetchChildernFolder(folderId: Int) {
        do {
            let filters: GetContentFilterRequest = .empty
            print(filters)
            
            try childernFolderUseCase.execute(folderId: folderId)
                .sink(receiveCompletion: handleSecretriesCompletion,
                      receiveValue: handleContentRequestsResult)
                .store(in: &cancellables)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func handleContentRequestsResult(folder: DomainWrapper<Folder>) {
        childernLoadingState = .loaded
        
        if folder.isSuccess, let childers = folder.data {
            self.childers = childers
            self.folderName = childers.name
        } else {
            print(folder.message)
            showErrorToast(message: folder.message)
        }
    }
}

// MARK: - Update Folder -

extension EditParentFolderViewModel {
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
            coordinator.popView()
        } else {
            print(contentRequests.message)
            showErrorToast(message: contentRequests.message)
        }
    }
}
