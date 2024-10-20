//
//  EditCourseUseCase.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 21/08/2024.
//

import Foundation

class EditCourseUseCase {
    private let repository: LibraryRepositoryProtocol
    
    init(repository: LibraryRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(params: UpdateCourseParameter) throws -> CoursePublisher {
        try repository.updateCourse(params: params)
            .toMainThread()
    }
    
    func deleteCourse(courseId: Int, params: DeleteCourseDTO) throws -> DeleteCoursePublisher {
        try repository.deleteCourse(courseId: courseId, params: params)
            .toMainThread()
    }
}
