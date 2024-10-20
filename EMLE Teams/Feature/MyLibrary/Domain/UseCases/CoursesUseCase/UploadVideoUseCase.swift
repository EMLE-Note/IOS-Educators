//
//  UploadVideoUseCase.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 06/10/2024.
//

import Foundation

class UploadVideoUseCase {
    private let repository: LibraryRepositoryProtocol
    
    init(repository: LibraryRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(params: UploadVideo) throws -> UploadVideoPublisher {
        try repository.uploadVideo(body: params)
            .toMainThread()
    }
}
