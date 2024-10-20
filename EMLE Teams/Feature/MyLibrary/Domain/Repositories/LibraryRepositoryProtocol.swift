//
//  LibraryRepositoryProtocol.swift
//  EMLE Teams
//
//  Created by iOSAYed on 16/08/2024.
//

import Foundation
import EMLECore

protocol LibraryRepositoryProtocol: RepositoryProtocol {
    func getCourses(params: GetCourses) throws -> GetCoursesPublisher
    func getContent(courseId: Int) throws -> GetContentPublisher
    func getChildernFolder(folderId: Int) throws -> GetChildernFolderPublisher
    func updateFolder(folderId: Int, params: UpdateFolderParameter) throws -> UpdateFolderPublisher
    func getStudents(couresId: Int, request: GetStudents) throws -> GetStudentPublisher
    func updateStudents(enrollmentId: Int, params: UpdateEnrollmentStudentParameter) throws -> UpdateEnrollmentStudentPublisher
    func createCourse(body: CreateCourseRequestFrom) throws -> CoursePublisher
    func updateCourse(params: UpdateCourseParameter) throws -> CoursePublisher
    func editCourseSecurity(params: EditCourseSecurityParameter) throws -> CoursePublisher
    func editCourseTarget(params: EditCourseTargetParameter) throws -> CoursePublisher
    func deleteFolder(folderId: Int, params: DeleteFolderDTO) throws -> DeleteFolderPublisher
    func deleteCourse(courseId: Int, params: DeleteCourseDTO) throws -> DeleteCoursePublisher
    func createGroup(params: CreateGroup) throws -> GroupPublisher
    func getGroup() throws -> GetGroupPublisher
    func deleteGroup(groupId: Int) throws -> DeleteGroupPublisher
    func uploadVideo(body: UploadVideo) throws -> UploadVideoPublisher
}
