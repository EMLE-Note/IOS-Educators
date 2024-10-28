//
//  CopyMaterilUseCase.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 23/10/2024.
//

import Foundation

class CopyMaterilUseCase {
    private let repository: LibraryRepositoryProtocol
    
    init(repository: LibraryRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(params: CopyMaterial) throws -> EditMaterilPublisher {
        try repository.copyMateril(body: params)
            .toMainThread()
    }
}
