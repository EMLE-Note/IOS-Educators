//
//  EditCourseSecurityUseCase.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 26/08/2024.
//

import Foundation

class EditCourseSecurityUseCase {
    private let repository: LibraryRepositoryProtocol
    
    init(repository: LibraryRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(params: EditCourseSecurityParameter) throws -> CoursePublisher {
        try repository.editCourseSecurity(params: params)
            .toMainThread()
    }
}
