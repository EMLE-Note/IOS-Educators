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

class LessonFolderDetailsViewModel: NSObject, MainViewModel {
    
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
            .downloadMaterial(materialLink: materil.link),
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
        case .downloadMaterial(materialLink: let materialLink):
            downloadMaterial(materialLink: materialLink)
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
    
    private func downloadMaterial(materialLink: String) {
        withOptionalAnimation {
            isOptianFolderViewPresented = false
        }
        
        guard let url = URL(string: materialLink) else {
            showErrorToast(message: "Invalid material link")
            return
        }
        
        startDownloadTask(with: url)
        
    }
    
    private func startDownloadTask(with url: URL) {
        // Set up background URL session configuration
        let config = URLSessionConfiguration.background(withIdentifier: "com.yourapp.backgroundDownload")
        config.timeoutIntervalForRequest = 30
        config.timeoutIntervalForResource = 60
        config.allowsCellularAccess = true
        config.httpShouldUsePipelining = true
        
        // Create the background session and initiate the download task
        let backgroundSession = URLSession(configuration: config, delegate: self, delegateQueue: nil)
        
        // Create download task
        let downloadTask = backgroundSession.downloadTask(with: url)
        
        // Start the download task
        downloadTask.resume()
    }
    
    // Utility function to define where the downloaded file will be saved
    private func getDestinationURL(for downloadTask: URLSessionDownloadTask) -> URL {
        let fileManager = FileManager.default
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        // You can also use `downloadTask.response?.suggestedFilename` if you want to name the file
        return documentsDirectory.appendingPathComponent(downloadTask.response?.suggestedFilename ?? "downloadedMaterial")
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

import Foundation

extension LessonFolderDetailsViewModel: URLSessionDownloadDelegate {
    // Called when the download finishes
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("Download finished to: \(location.path)")

        let destinationURL = getDestinationURL(for: downloadTask)

        do {
            // Ensure the destination doesn't already contain the file
            if FileManager.default.fileExists(atPath: destinationURL.path) {
                try FileManager.default.removeItem(at: destinationURL)
            }
            
            // Move the file to the destination
            try FileManager.default.moveItem(at: location, to: destinationURL)
            
            DispatchQueue.main.async {
                showSuccessToast(message: "The download has completed successfully.")
            }
        } catch {
            DispatchQueue.main.async {
                showErrorToast(message: "File move error: \(error.localizedDescription)")
            }
        }
    }

    // Called when there's an error with the download task
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFailWithError error: Error) {
        // Notify the user that the download failed
        DispatchQueue.main.async {
            showErrorToast(message: error.localizedDescription)
        }
    }

    // Called when all background session tasks are finished
    func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        // Handle session completion or any final tasks
        DispatchQueue.main.async {
            showErrorToast(message: "events finished")
        }
    }
    
}
