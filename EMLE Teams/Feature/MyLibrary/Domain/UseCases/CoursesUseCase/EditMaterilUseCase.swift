//
//  EditMaterilUseCase.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 23/10/2024.
//

import Foundation

class EditMaterilUseCase {
    private let repository: LibraryRepositoryProtocol
    
    init(repository: LibraryRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(params: EditMatrail) throws -> EditMaterilPublisher {
        try repository.editMateril(body: params)
            .toMainThread()
    }
}
