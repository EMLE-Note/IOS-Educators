//
//  DeleteGroupUseCase.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 01/09/2024.
//

import Foundation

class DeleteGroupUseCase {
    private let repository: LibraryRepositoryProtocol
    
    init(repository: LibraryRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(groupId: Int) throws -> DeleteGroupPublisher {
        try repository.deleteGroup(groupId: groupId)
            .toMainThread()
    }
}
