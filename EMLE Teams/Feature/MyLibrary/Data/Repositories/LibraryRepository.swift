//
//  LibraryRepository.swift
//  EMLE Teams
//
//  Created by iOSAYed on 16/08/2024.
//
import Foundation
import Combine
import EMLECore

typealias GetCoursesPublisher = DomainPublisher<PaginatedContent<[Course]>>
typealias GetContentPublisher = DomainPublisher<Course>
typealias UpdateFolderPublisher = DomainPublisher<ChildrenFolder>
typealias GetChildernFolderPublisher = DomainPublisher<Folder>
typealias GetStudentPublisher = DomainPublisher<EnrollmentResponse>
typealias UpdateEnrollmentStudentPublisher = DomainPublisher<UpdateEnrollmentStudentsResponse>
typealias CoursePublisher = DomainPublisher<Course>
typealias DeleteFolderPublisher = DomainPublisher<DeleteFolderResponse>
typealias DeleteCoursePublisher = DomainPublisher<DeleteCourseResponse>
typealias GroupPublisher = DomainPublisher<GroupResponse>
typealias GetGroupPublisher = DomainPublisher<[GroupCourse]>
typealias DeleteGroupPublisher = DomainPublisher<DeleteGroupResponse>
typealias UploadVideoPublisher = DomainPublisher<UploadVideoResponse>

class LibraryRepository: LibraryRepositoryProtocol {
 
    private let dataSource: LibraryDataSourceProtocol
    
    init(dataSource: LibraryDataSourceProtocol) {
        self.dataSource = dataSource
    }
   
    func getCourses(params: GetCourses) throws -> GetCoursesPublisher {
        try dataSource.getCourses(params: params)
            .tryMap { $0.toDomainWrapper(with: try $0.data?.toDomain()) }
            .mapError()
            .eraseToAnyPublisher()
    }
    
    func getContent(courseId: Int) throws -> GetContentPublisher {
        try dataSource.getContent(courseId: courseId)
            .tryMap { $0.toDomainWrapper(with: try $0.data?.toDomain()) }
            .mapError()
            .eraseToAnyPublisher()
    }
    
    func getStudents(couresId: Int, request: GetStudents) throws -> GetStudentPublisher {
        try dataSource.getStudents(couresId: couresId, params: request)
            .tryMap { $0.toDomainWrapper(with: try $0.data?.toDomain()) }
            .mapError()
            .eraseToAnyPublisher()
    }
    
    func updateStudents(enrollmentId: Int, params: UpdateEnrollmentStudentParameter) throws -> UpdateEnrollmentStudentPublisher {
        try dataSource.updateStudent(enrollmentId: enrollmentId, params: params)
            .tryMap { $0.toDomainWrapper(with: nil) }
            .mapError()
            .eraseToAnyPublisher()
    }
    
    func updateFolder(folderId: Int, params: UpdateFolderParameter) throws -> UpdateFolderPublisher {
        try dataSource.updateFolder(folder: folderId, params: params)
            .tryMap { $0.toDomainWrapper(with: try $0.data?.toDomain()) }
            .mapError()
            .eraseToAnyPublisher()
    }
    
    func deleteFolder(folderId: Int, params: DeleteFolderDTO) throws -> DeleteFolderPublisher {
        try dataSource.deleteFolder(folder: folderId, params: params)
            .tryMap { $0.toDomainWrapper(with: nil) }
            .mapError()
            .eraseToAnyPublisher()
    }
    
    func getChildernFolder(folderId: Int) throws -> GetChildernFolderPublisher {
        try dataSource.getChilderFolder(folderId: folderId)
            .tryMap { $0.toDomainWrapper(with: try $0.data?.toDomain()) }
            .mapError()
            .eraseToAnyPublisher()
    }
    
    func createCourse(body: CreateCourseRequestFrom) throws -> CoursePublisher {
        try dataSource.createCourse(body: body)
            .tryMap { $0.toDomainWrapper(with: try $0.data?.toDomain()) }
            .mapError()
            .eraseToAnyPublisher()
    }
    
    func updateCourse(params: UpdateCourseParameter) throws -> CoursePublisher {
        try dataSource.updateCourse(params: params)
            .tryMap { $0.toDomainWrapper(with: try $0.data?.toDomain()) }
            .mapError()
            .eraseToAnyPublisher()
    }
    
    func editCourseSecurity(params: EditCourseSecurityParameter) throws -> CoursePublisher {
        try dataSource.editCourseSecuirty(params: params)
            .tryMap { $0.toDomainWrapper(with: try $0.data?.toDomain()) }
            .mapError()
            .eraseToAnyPublisher()
    }
    
    func editCourseTarget(params: EditCourseTargetParameter) throws -> CoursePublisher {
        try dataSource.editCourseTarget(params: params)
            .tryMap { $0.toDomainWrapper(with: try $0.data?.toDomain()) }
            .mapError()
            .eraseToAnyPublisher()
    }
    
    func deleteCourse(courseId: Int, params: DeleteCourseDTO) throws -> DeleteCoursePublisher {
        try dataSource.deleteCourse(courseId: courseId, params: params)
            .tryMap { $0.toDomainWrapper(with: nil) }
            .mapError()
            .eraseToAnyPublisher()
    }
    
    func createGroup(params: CreateGroup) throws -> GroupPublisher {
        try dataSource.createGroup(params: params)
            .tryMap { $0.toDomainWrapper(with: try $0.data?.toDomain()) }
            .mapError()
            .eraseToAnyPublisher()
    }
    
    func getGroup() throws -> GetGroupPublisher {
        try dataSource.getGroup()
            .tryMap { $0.toDomainWrapper(with: try $0.data?.toDomain()) }
            .mapError()
            .eraseToAnyPublisher()
    }
    
    func deleteGroup(groupId: Int) throws -> DeleteGroupPublisher {
        try dataSource.deleteGroup(groupId: groupId)
            .tryMap { $0.toDomainWrapper(with: nil) }
            .mapError()
            .eraseToAnyPublisher()
    }
    
    func uploadVideo(body: UploadVideo) throws -> UploadVideoPublisher {
        try dataSource.uploadVideo(body: body)
            .tryMap { $0.toDomainWrapper(with: try $0.data?.toDomain()) }
            .mapError()
            .eraseToAnyPublisher()
    }
}
