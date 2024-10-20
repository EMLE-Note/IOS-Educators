//
//  EditCourseTargetUseCase.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 15/09/2024.
//

import Foundation

class EditCourseTargetUseCase {
    private let repository: LibraryRepositoryProtocol
    
    init(repository: LibraryRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(params: EditCourseTargetParameter) throws -> CoursePublisher {
        try repository.editCourseTarget(params: params)
            .toMainThread()
    }
}
