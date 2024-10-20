//
//  LibraryDataUseCase.swift
//  EMLE Teams
//
//  Created by iOSAYed on 16/08/2024.
//

import Foundation

class LibraryDataUseCase {
    private let repository: LibraryRepositoryProtocol
    
    init(repository: LibraryRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(params: GetCourses) throws -> GetCoursesPublisher {
        try repository.getCourses(params: params)
            .toMainThread()
    }
}
