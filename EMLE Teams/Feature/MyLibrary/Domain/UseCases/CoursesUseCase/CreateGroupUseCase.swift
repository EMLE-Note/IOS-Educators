//
//  CreateGroupUseCase.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 31/08/2024.
//

import Foundation

class CreateGroupUseCase {
    private let repository: LibraryRepositoryProtocol
    
    init(repository: LibraryRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(params: CreateGroup) throws -> GroupPublisher {
        try repository.createGroup(params: params)
            .toMainThread()
    }
}
