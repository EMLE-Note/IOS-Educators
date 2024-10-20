//
//  CreateCourseUseCase.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 19/09/2024.
//

import Foundation

class CreateCourseUseCase {
    private let repository: LibraryRepositoryProtocol
    
    init(repository: LibraryRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(body: CreateCourseRequestFrom) throws -> CoursePublisher {
        try repository.createCourse(body: body)
            .toMainThread()
    }
}
