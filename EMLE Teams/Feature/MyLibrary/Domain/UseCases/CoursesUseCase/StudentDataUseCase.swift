//
//  StudentDataUseCase.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 19/08/2024.
//

import Foundation

class StudentDataUseCase {
    private let repository: LibraryRepositoryProtocol
    
    init(repository: LibraryRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(couresId: Int, request: GetStudents) throws -> GetStudentPublisher {
        try repository.getStudents(couresId: couresId, request: request)
            .toMainThread()
    }
    
    func execute(enrollmentId: Int, params: UpdateEnrollmentStudentParameter) throws -> UpdateEnrollmentStudentPublisher {
        try repository.updateStudents(enrollmentId: enrollmentId, params: params)
            .toMainThread()
    }
}
