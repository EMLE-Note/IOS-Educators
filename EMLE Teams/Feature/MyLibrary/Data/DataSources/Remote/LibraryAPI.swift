//
//  LibraryAPI.swift
//  EMLE Teams
//
//  Created by iOSAYed on 16/08/2024.
//

import Foundation
import EMLECore

protocol LibraryAPIProtocol: APIProtocol {
    func getCourses(request: GetCoursesRequest) throws -> APIDataPublisher
    func getContent(couresId: Int) throws -> APIDataPublisher
    func getChildenFolder(folderId: Int) throws -> APIDataPublisher
    func getStudents(couresId: Int, request: GetStudentsRequest) throws -> APIDataPublisher
    func updateEnrollmentStudent(enrollmentId: Int, request: UpdateEnrollmentStudentRequest) throws -> APIDataPublisher
    func createCourse(request: CreateCourseRequest) throws -> APIDataPublisher
    func updateCourse(request: EditCourseSettingRequest) throws -> APIDataPublisher
    func editCourseSecurity(request: EditCourseSecurityRequest) throws -> APIDataPublisher
    func editCourseTarget(request: EditCourseTargetRequest) throws -> APIDataPublisher
    func updateFolder(folderId: Int, request: UpdateFolderRequest) throws -> APIDataPublisher
    func deleteFolder(folderId: Int, request: DeleteFolderRequest) throws -> APIDataPublisher
    func deleteCourse(courseId: Int, request: DeleteCourseRequest) throws -> APIDataPublisher
    func createGroup(request: CreateGroupRequest) throws -> APIDataPublisher
    func getGroup(request: GetGroupRequest) throws -> APIDataPublisher
    func deleteGroup(request: DeleteGroupResquest) throws -> APIDataPublisher
    func uploadVideo(request: UploadVideoRequest) throws -> APIDataPublisher
    func editMateril(request: EditMatrailRequest) throws -> APIDataPublisher
    func copyMateril(request: CopyMaterilRequest) throws -> APIDataPublisher
}

class LibraryAPI: LibraryAPIProtocol {
 
    var networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    func getCourses(request: GetCoursesRequest) throws -> APIDataPublisher {
        return try sendTeamAuthorizedAPICall(request: request)
    } 
    
    func getContent(couresId: Int) throws -> APIDataPublisher {
        let request = ContentCourseRequestDTO(courseId: couresId)
        return try sendTeamAuthorizedAPICall(request: request)
    }
    
    func getChildenFolder(folderId: Int) throws -> APIDataPublisher {
        let request = ChildrenFolderRequest(folderId: folderId)
        return try sendTeamAuthorizedAPICall(request: request)
    }
    
    func getStudents(couresId: Int, request: GetStudentsRequest) throws -> APIDataPublisher {
        let requestwithId = request
        requestwithId.courseId = couresId
        return try sendTeamAuthorizedAPICall(request: requestwithId)
    }
    
    func updateEnrollmentStudent(enrollmentId: Int, request: UpdateEnrollmentStudentRequest) throws -> APIDataPublisher {
        let requestwithId = request
        requestwithId.enrollmentId = enrollmentId
        return try sendTeamAuthorizedAPICall(request: request)
    }
    
    func updateFolder(folderId: Int, request: UpdateFolderRequest) throws -> APIDataPublisher {
        let requestwithId = request
        requestwithId.folderId = folderId
        return try sendTeamAuthorizedAPICall(request: request)
    }
    
    func deleteFolder(folderId: Int, request: DeleteFolderRequest) throws -> APIDataPublisher {
        let requestwithId = request
        requestwithId.folderId = folderId
        return try sendTeamAuthorizedAPICall(request: request)
    }
    
    func createCourse(request: CreateCourseRequest) throws -> APIDataPublisher {
        return try sendTeamAuthorizedFormAPICall(request: request)
    }
    
    func updateCourse(request: EditCourseSettingRequest) throws -> APIDataPublisher {
        return try sendTeamAuthorizedFormAPICall(request: request)
    }
    
    func editCourseSecurity(request: EditCourseSecurityRequest) throws -> APIDataPublisher {
        return try sendTeamAuthorizedAPICall(request: request)
    }
    
    func editCourseTarget(request: EditCourseTargetRequest) throws -> APIDataPublisher {
        return try sendTeamAuthorizedAPICall(request: request)
    }
    
    func deleteCourse(courseId: Int, request: DeleteCourseRequest) throws -> APIDataPublisher {
        let requestwithId = request
        requestwithId.courseId = courseId
        return try sendTeamAuthorizedAPICall(request: request)
    }
    
    func createGroup(request: CreateGroupRequest) throws -> APIDataPublisher {
        return try sendTeamAuthorizedAPICall(request: request)
    }
    
    func getGroup(request: GetGroupRequest) throws -> APIDataPublisher {
        return try sendTeamAuthorizedAPICall(request: request)
    }
    
    func deleteGroup(request: DeleteGroupResquest) throws -> APIDataPublisher {
        return try sendTeamAuthorizedAPICall(request: request)
    }
    
    func uploadVideo(request: UploadVideoRequest) throws -> APIDataPublisher {
        return try sendTeamAuthorizedAPICall(request: request)
    }
    
    func editMateril(request: EditMatrailRequest) throws -> APIDataPublisher {
        return try sendTeamAuthorizedAPICall(request: request)
    }
    
    func copyMateril(request: CopyMaterilRequest) throws -> APIDataPublisher {
        return try sendTeamAuthorizedAPICall(request: request)
    }
}


