//
//  ChildernFolderUseCase.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 20/08/2024.
//

import Foundation

class ChildernFolderUseCase {
    private let repository: LibraryRepositoryProtocol
    
    init(repository: LibraryRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(folderId: Int) throws -> GetChildernFolderPublisher {
        try repository.getChildernFolder(folderId: folderId)
            .toMainThread()
    }
}
