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
    let defaultsManager = UserDefaultsManage()
    
    @Published var isOptianFolderViewPresented = false
    @Published var folderMaterial: [FolderMaterial] = []
    @Published var folder: Folder = .placeholder
    @Published var childernLoadingState: LoadingState = .loaded
    @Published var contentOptions: [MaterialOptionType] = []
    
    @Inject var childernFolderUseCase: ChildernFolderUseCase
    @Inject var editMaterilUseCase: EditMaterilUseCase
    @Inject var copyMaterilUseCase: CopyMaterilUseCase
}

extension LessonFolderDetailsViewModel {
    func onAppear() {
        fetchMaterialFolder(folderId: folderId)
    }
    
    func editCourseTapped() {
        coordinator.goToEditParentFolder(folderId: folderId)
    }
    
    func onClickedOptianContent(materil: FolderMaterial) {
        withOptionalAnimation {
            isOptianFolderViewPresented = true
        }
        selectedFolderId = folderId
        
        contentOptions = [
            .downloadMaterial,
            .editMaterial,
            .hideLesson,
            .copyLesson(materilId: materil.materialId),
            .setFreeMaterial(materilId: materil.materialId, isFree: materil.isFree),
            .deleteLesson
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
    func handleAction(for option: MaterialOptionType) {
        switch option {
        case .downloadMaterial: return
        case .editMaterial: return
        case .hideLesson: return
        case .copyLesson(materilId: let materilId):
            copyLesson(materilId: materilId)
        case .setFreeMaterial(materilId: let materilId, isFree: let isFree):
            toggleFreeMateril(materilId: materilId, isFree: isFree)
        case .deleteLesson:
            return
        }
    }
    
    private func toggleFreeMateril(materilId: Int, isFree: Bool) {
        withOptionalAnimation {
            isOptianFolderViewPresented = false
        }
        editMaterialFree(materialId: materilId, isFree: isFree ? 0 : 1)
    }
    
    private func copyLesson(materilId: Int) {
        withOptionalAnimation {
            isOptianFolderViewPresented = false
        }
        
        defaultsManager.setMaterialId(materilId)
        
        showSuccessToast(message: "Copied")
    }
    
    func pastedMaterialTapped() {
        if let materialId = defaultsManager.getMaterialId() {
            copyMaterial(materialId: materialId, persist: 1)
            defaultsManager.removeMaterialId()
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

// MARK: - Edit Materil -

extension LessonFolderDetailsViewModel {
    private func editMaterialFree(materialId: Int, isFree: Int) {
        do {
            childernLoadingState = .loading
            let params: EditMatrail = EditMatrail(materilId: materialId, isFree: isFree)
            
            try editMaterilUseCase.execute(params: params)
                .sink(receiveCompletion: handleSecretriesCompletion,
                      receiveValue: handleMaterilResponse)
                .store(in: &cancellables)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func handleMaterilResponse(matrial: DomainWrapper<FolderMaterial>) {
        childernLoadingState = .loaded
        
        guard matrial.isSuccess else {
            let errorMessage = matrial.message
            showErrorToast(message: errorMessage)
            return
        }
        
        showSuccessToast(message: matrial.message)
        fetchMaterialFolder(folderId: folderId)
    }
}

extension LessonFolderDetailsViewModel {
    private func copyMaterial(materialId: Int, persist: Int) {
        do {
            childernLoadingState = .loading
            let params: CopyMaterial = CopyMaterial(materilId: materialId, courseFolderId: folder.folderId, persist: persist)
            
            try copyMaterilUseCase.execute(params: params)
                .sink(receiveCompletion: handleSecretriesCompletion,
                      receiveValue: handleMaterilResponse)
                .store(in: &cancellables)
        } catch {
            print(error.localizedDescription)
        }
    }
}
