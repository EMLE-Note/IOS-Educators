//
//  GetGroupUseCase.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 01/09/2024.
//

import Foundation

class GetGroupUseCase {
    private let repository: LibraryRepositoryProtocol
    
    init(repository: LibraryRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() throws -> GetGroupPublisher {
        try repository.getGroup()
            .toMainThread()
    }
}
