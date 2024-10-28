//
//  LibraryDataSource.swift
//  EMLE Teams
//
//  Created by iOSAYed on 16/08/2024.
//

import Foundation
import Combine
import EMLECore

typealias GetCoursesResponsePublisher = ResponsePublisher<GetCoursesResponseDTO>
typealias GetContentResponsePublisher = ResponsePublisher<CourseDTO>
typealias GetChildernFolderResponsePublisher = ResponsePublisher<FolderDTO>
typealias UpdateFolderResponsePublisher = ResponsePublisher<ChildrenFolderDTO>
typealias DeleteFolderResponsePublisher = ResponsePublisher<DeleteFolderResponseDTO>
typealias DeleteCourseResponsePublisher = ResponsePublisher<DeleteCourseResponseDTO>
typealias GetStudentsResponsePublisher = ResponsePublisher<GetStudentsResponseDTO>
typealias UpdateEnrollmentStudentsResponsePublisher = ResponsePublisher<UpdateEnrollmentStudentsResponseDTO>
typealias CourseResponsePublisher = ResponsePublisher<CourseDTO>
typealias GroupResponsePublisher = ResponsePublisher<GroupResponseDTO>
typealias GetGroupResponsePublisher = ResponsePublisher<[GroupDTO]>
typealias DeleteGroupResponsePublisher = ResponsePublisher<DeleteGroupResponseDTO>
typealias UploadVideoResponsePublisher = ResponsePublisher<UploadVideoResponseDTO>
typealias EditMaterilResponsePublisher = ResponsePublisher<MeterialDTO>

protocol LibraryDataSourceProtocol: RemoteDataSourceProtocol {
    func getCourses(params: GetCourses) throws -> GetCoursesResponsePublisher
    func getContent(courseId: Int) throws -> GetContentResponsePublisher
    func getChilderFolder(folderId: Int) throws -> GetChildernFolderResponsePublisher
    func updateFolder(folder: Int, params: UpdateFolderParameter) throws -> UpdateFolderResponsePublisher
    func deleteFolder(folder: Int, params: DeleteFolderDTO) throws -> DeleteFolderResponsePublisher
    func deleteCourse(courseId: Int, params: DeleteCourseDTO) throws -> DeleteCourseResponsePublisher
    func getStudents(couresId: Int, params: GetStudents) throws -> GetStudentsResponsePublisher
    func updateStudent(enrollmentId: Int, params: UpdateEnrollmentStudentParameter) throws -> UpdateEnrollmentStudentsResponsePublisher
    func createCourse(body: CreateCourseRequestFrom) throws -> CourseResponsePublisher
    func updateCourse(params: UpdateCourseParameter) throws -> CourseResponsePublisher
    func editCourseSecuirty(params: EditCourseSecurityParameter) throws -> CourseResponsePublisher
    func editCourseTarget(params: EditCourseTargetParameter) throws -> CourseResponsePublisher
    func createGroup(params: CreateGroup) throws -> GroupResponsePublisher
    func getGroup() throws -> GetGroupResponsePublisher
    func deleteGroup(groupId: Int) throws -> DeleteGroupResponsePublisher
    func uploadVideo(body: UploadVideo) throws -> UploadVideoResponsePublisher
    func editMateril(body: EditMatrail) throws -> EditMaterilResponsePublisher
    func copyMateril(body: CopyMaterial) throws -> EditMaterilResponsePublisher
}

class LibraryDataSource: LibraryDataSourceProtocol {

    private let api: LibraryAPIProtocol
    
    init(api: LibraryAPIProtocol) {
        self.api = api
    }
    
    func getCourses(params: GetCourses) throws -> GetCoursesResponsePublisher {
        try api.getCourses(request: params.toRequest())
            .toResponsePublisher()
    }
    
    func getContent(courseId: Int) throws -> GetContentResponsePublisher {
        try api.getContent(couresId: courseId)
            .toResponsePublisher()
    }
    
    func getStudents(couresId: Int, params: GetStudents) throws -> GetStudentsResponsePublisher {
        try api.getStudents(couresId: couresId, request: params.toRequest())
            .toResponsePublisher()
    }
    
    func updateStudent(enrollmentId: Int, params: UpdateEnrollmentStudentParameter) throws -> UpdateEnrollmentStudentsResponsePublisher {
        try api.updateEnrollmentStudent(enrollmentId: enrollmentId, request: params.toRequest())
            .toResponsePublisher()
    }
    
    func updateFolder(folder: Int, params: UpdateFolderParameter) throws -> UpdateFolderResponsePublisher {
        try api.updateFolder(folderId: folder, request: params.toRequest())
            .toResponsePublisher()
    }
    
    func deleteFolder(folder: Int, params: DeleteFolderDTO) throws -> DeleteFolderResponsePublisher {
        try api.deleteFolder(folderId: folder, request: params.toRequest())
            .toResponsePublisher()
    }
    
    func getChilderFolder(folderId: Int) throws -> GetChildernFolderResponsePublisher {
        try api.getChildenFolder(folderId: folderId)
            .toResponsePublisher()
    }
    
    func createCourse(body: CreateCourseRequestFrom) throws -> CourseResponsePublisher {
        try api.createCourse(request: body.toRequest())
            .toResponsePublisher()
    }
    
    func updateCourse(params: UpdateCourseParameter) throws -> CourseResponsePublisher {
        try api.updateCourse(request: params.toRequest())
            .toResponsePublisher()
    }
    
    func editCourseSecuirty(params: EditCourseSecurityParameter) throws -> CourseResponsePublisher {
        try api.editCourseSecurity(request: params.toRequest())
            .toResponsePublisher()
    }
    
    func editCourseTarget(params: EditCourseTargetParameter) throws -> CourseResponsePublisher {
        try api.editCourseTarget(request: params.toRequest())
            .toResponsePublisher()
    }
    
    func deleteCourse(courseId: Int, params: DeleteCourseDTO) throws -> DeleteCourseResponsePublisher {
        try api.deleteCourse(courseId: courseId, request: params.toRequest())
            .toResponsePublisher()
    }
    
    func createGroup(params: CreateGroup) throws -> GroupResponsePublisher {
        try api.createGroup(request: params.toRequest())
            .toResponsePublisher()
    }
    
    func getGroup() throws -> GetGroupResponsePublisher {
        try api.getGroup(request: GetGroupRequest())
            .toResponsePublisher()
    }
    
    func deleteGroup(groupId: Int) throws -> DeleteGroupResponsePublisher {
        try api.deleteGroup(request: DeleteGroupResquest(groupId: groupId))
            .toResponsePublisher()
    }
    
    func uploadVideo(body: UploadVideo) throws -> UploadVideoResponsePublisher {
        try api.uploadVideo(request: body.toRequest())
            .toResponsePublisher()
    }
    
    func editMateril(body: EditMatrail) throws -> EditMaterilResponsePublisher {
        try api.editMateril(request: body.toRequest())
            .toResponsePublisher()
    }
    
    func copyMateril(body: CopyMaterial) throws -> EditMaterilResponsePublisher {
        try api.copyMateril(request: body.toRequest())
            .toResponsePublisher()
    }
}
