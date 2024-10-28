//
//  UploadMaterialViewModel.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 05/10/2024.
//

import Foundation
import EMLECore
import SwiftUI
import Combine

class UploadMaterialViewModel: MainViewModel {
    
    var isTabBarVisible: Bool { false }
    var cancellables = Set<AnyCancellable>()
    
    let coordinator: UploadMaterialCoordinating
    let folderId: Int
    
    init(folderId: Int, coordinator: UploadMaterialCoordinating) {
        self.coordinator = coordinator
        self.folderId = folderId
    }
    
    @Published var isPresented: Bool = false
    @Published var selectedUploadMaterial: UploadMaterialType = .emleServer
    @Published var selectedUploadType: VideoType?
    @Published var uploadType: Int = 2
    @Published var videoName: String = ""
    @Published var link: String = ""
    @Published var contentLoadingState: LoadingState = .loaded
    
    var isUploadButtonEnabled: Bool {
        !videoName.isEmpty && !link.isEmpty
    }
    
    @Inject var uploadVideoUseCase: UploadVideoUseCase
}

extension UploadMaterialViewModel {
    func onAppear() {
        
    }
    
    func toggleVisibility() {
        withAnimation(.spring()) {
            isPresented.toggle()
        }
    }
    
    func close() {
        withAnimation(.spring()) {
            isPresented = false
            coordinator.dismiss()
        }
    }
    
    func selectedVideoTapped() {
        
    }
    
    func uploadTapped() {
        print("Uploading...")
        uploadVideo()
    }
    
    func performActionFor(option: VideoType) {
            uploadType = option.uploadTypeValue
            switch option {
            case .youtube:
                break
            case .googleDrive:
                break
            case .vimeo:
                break
            case .publitio:
                break
            }
        }
}

extension UploadMaterialViewModel {
    func uploadVideo() {
        do {
            let video = Video(duration: 0, size: 0, serverId: 1, uploadType: uploadType, link: link)
            
            let params = UploadVideo(name: videoName, isVisible: true, shouldPass: false, isFree: false, courseFolderId: folderId, file: nil, video: video)
            
            try uploadVideoUseCase.execute(params: params)
                .sink(receiveCompletion: handleSecretriesCompletion,
                      receiveValue: handleContentRequestsResult)
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
            contentLoadingState = .failed
        }
    }
    
    func handleContentRequestsResult(contentRequests: DomainWrapper<UploadVideoResponse>) {
        contentLoadingState = .loaded
        
        if contentRequests.isSuccess {
            showSuccessToast(message: contentRequests.message)
            self.coordinator.dismiss()
        } else {
            print(contentRequests.message)
            showErrorToast(message: contentRequests.message)
        }
    }
}
