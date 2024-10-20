//
//  ContentDataUseCase.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 17/08/2024.
//

import Foundation

class ContentDataUseCase {
    private let repository: LibraryRepositoryProtocol
    
    init(repository: LibraryRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(courseId: Int) throws -> GetContentPublisher {
        try repository.getContent(courseId: courseId)
            .toMainThread()
    }
    
    func updateFolder(folderId: Int, params: UpdateFolderParameter) throws -> UpdateFolderPublisher {
        try repository.updateFolder(folderId: folderId, params: params)
            .toMainThread()
    }
    
    func deleteFolder(folderId: Int, params: DeleteFolderDTO) throws -> DeleteFolderPublisher {
        try repository.deleteFolder(folderId: folderId, params: params)
            .toMainThread()
    }
}
