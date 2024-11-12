//
//  LibraryMapper.swift
//  EMLE Teams
//
//  Created by iOSAYed on 16/08/2024.
//

import Foundation
import EMLECore


extension GetCoursesResponseDTO {
    func toDomain() throws -> PaginatedContent<[Course]> {
        let content = try courses.toDomain()
        return pagination.toDomain(content: content)
//        return CoursesResponse(courses: content, pagination: pagination.toDomain(content: content))
    }
}


extension GetStudentsResponseDTO {
    func toDomain() throws -> EnrollmentResponse {
        let content = try enrollments.toDomain()
        return EnrollmentResponse(enrollments: content, pagination: pagination.toDomain(content: content))
    }
}

extension GroupResponseDTO {
    func toDomain() throws -> GroupResponse {
        return GroupResponse(id: id, name: name, courses: try courses.toDomain())
    }
}

extension CreateGroupDTO {
    func toDomain() -> CreateGroup {
        CreateGroup(name: name)
    }
}

extension CourseDTO {
    func toDomain() throws -> Course {
        
        var imageUrl: ImageUrl? = nil
        
        if let image {
            imageUrl = ImageUrl(urlString: image)
        }
        
        let team = team?.toDomain()
        
        let folders = try folders?.toDomain() ?? []
        let targets = try targets?.toDomain() ?? []
        let groups = try groups?.toDomain() ?? []
        
        let security = security?.toDomain() ?? .defaultSecurity
        
        return Course(
            courseId: id,
            uuid: uuid ?? "",
            name: name,
            overview: overview ?? "",
            image: imageUrl,
            status: status ?? 0,
            duration: duration ?? 0,
            price: price ?? 0.0,
            currency: currency ?? "",
            publishAt: publish_at ?? "",
            studentsCount: students_count ?? 0,
            videosDuration: videos_duration ?? 0,
            booksCount: books_count ?? 0,
            quizCount: quiz_count ?? 0,
            foldersCount: folders_count ?? 0,
            targets: targets,
            team: team ?? .empty,
            folders: folders,
            security: security,
            isAllowedOffline: is_allowed_offline ?? false,
            groups: groups
        )
    }
}

extension [CourseDTO] {
    func toDomain() throws -> [Course] {
        try map { try $0.toDomain() }
    }
}

extension TargetDTO {
    func toDomain() -> Target {
        return Target(targetId: id, name: name, field: field?.toDomain(parentId: nil) ?? .placeholder, institution: institution?.toDomain() ?? .placeholder, type: type?.toDomain() ?? .placeholder)
    }
}

extension SecurityDTO {
    func toDomain() -> Security {
        
        Security(fingerPrintTime: (finger_print_time ?? 0),
                 studentNameTime: (student_name_time ?? 0),
                 preventScreenRecord: prevent_screen_record ?? false,
                 notificationSecurity: notification_security ?? false,
                 headphoneSecurity: headphone_security ?? false,
                 nationalIdSecurity: national_id_security ?? false,
                 faceRecognitionSecurity: face_recognition_security ?? false,
                 signature: signature?.toDomain())
    }
}

extension [TargetDTO] {
    func toDomain() throws -> [Target] {
         map { $0.toDomain() }
    }
}


extension SignatureDTO {
    func toDomain() -> Signature {
        return Signature(fontSize: font_size, fontWeight: font_weight)
    }
}

extension GroupDTO {
    func toDomain() throws -> GroupCourse {
        return try GroupCourse(groupId: id, name: name, courses: courses?.toDomain())
    }
}

extension [GroupDTO] {
    func toDomain() throws -> [GroupCourse] {
        try map { try $0.toDomain() }
    }
}

extension TeamDTO {
    func toDomain() -> Team {
        var imageUrl = ImageUrl(urlString: "")
        
        if let image = image {
            imageUrl = ImageUrl(urlString: image)
        }
        
        return Team(teamId: id, name: name, type: type, about: about, situation: situation, hasCurrentDeal: has_current_deal, image: imageUrl, owner: owner.toDomain(), createdAt: "", updatedAt: "")
    }
}

extension GetCoursesFilterRequest {
    func toRequestDTO() -> GetCoursesFilterRequestDTO {
        GetCoursesFilterRequestDTO(fieldId: fieldId, fieldName: fieldName, teamId: teamId, teamName: teamName, uuid: uuid, institutionName: institutionName, institutionId: institutionId, search: search, sort: sort)
    }
}

extension GetCourses {
    func toRequest() -> GetCoursesRequest {
        GetCoursesRequest(filters: filters.toRequestDTO())
    }
}

extension [FolderDTO] {
    func toDomain() throws -> [Folder] {
        
        var domain = try map { try $0.toDomain() }
        
        domain.sort { $0.sort < $1.sort }
        
        return domain
    }
}

extension FolderDTO {
    func toDomain() throws -> Folder {
        
        guard let folderType = FolderType(rawValue: type) else {
            throw UseCaseError.decodingError(message: "Folder type parsing error")
        }
        
        guard let folderLevel = FolderLevel(rawValue: level ?? 1) else {
            throw UseCaseError.decodingError(message: "Folder level parsing error")
        }
        
        var children = try children?.toDomain() ?? []
        
        let materials = try materials?.toDomain() ?? []
        
        let parent = try parent?.toDomain() ?? nil
        
        for i in 0..<children.count {
            children[i].parentId = id
        }
        
        return Folder(folderId: id,
                      name: name,
                      sort: sort,
                      type: folderType,
                      level: folderLevel,
                      videosDuration: videos_duration,
                      booksCount: books_count,
                      quizCount: quiz_count,
                      isVisible: is_visible,
                      foldersCount: folders_count ?? 0,
                      children: children,
                      materials: materials,
                      parent: parent,
                      parentId: nil)
        
    }
}

extension [MeterialDTO] {
    func toDomain() throws -> [FolderMaterial] {
        try map { try $0.toDomain() }
    }
}

extension MeterialDTO {
    func toDomain() throws -> FolderMaterial {
        
        guard let materialType = MaterialType(rawValue: type) else {
            throw UseCaseError.decodingError(message: "Material type parsing error")
        }
        
        let materialable = try materialable.toDomain()
        
        return FolderMaterial(materialId: id,
                              name: name,
                              sort: sort,
                              type: materialType,
                              shouldPass: should_pass,
                              isFree: is_free ,
                              materialable: materialable)
    }
}

extension MaterialableDTO {
    func toDomain() throws -> Materialable {
 
        return Materialable(id: 0,
                            duration: duration ?? 0,
                            serverId: server_id ?? 0,
                            size: size ?? 0,
                            link: link ?? "",
                            streamingLink: streaming_link ?? "",
                            uploadType: upload_type ?? 1,
                            pagesCount: pages_count ?? 0,
                            questions: [])
    }
}

extension ParentFolderDTO {
    func toDomain() throws -> ParentFolder {
        return ParentFolder(id: id,
                            name: name,
                            sort: sort,
                            type: type,
                            level: level,
                            isVisible: is_visible,
                            videosDuration: videos_duration ?? 0,
                            booksCount: book_count ?? 0,
                            quizCount: quiz_count ?? 0
        )
    }
}

extension QuestionDTO {
    func toDomain() -> Question {
        return Question(question: question, description: description, type: type, correctAnswer: correct_answer, answers: answers, explanations: explanations, audio: audio, reference: reference)
    }
}

extension [QuestionDTO] {
    func toDomain() throws -> [Question] {
        try map { try $0.toDomain() }
    }
}

extension GetContentFilterRequest {
    func toRequestDTO() -> GetContentFilterRequestDTO {
        GetContentFilterRequestDTO(fieldId: fieldId, uuid: uuid)
    }
}

extension [EnrollmentStudentDTO] {
    func toDomain() throws -> [EnrollmentStudent] {
        try map { try $0.toDomain() }
    }
}

extension EnrollmentStudentDTO {
    func toDomain() -> EnrollmentStudent {
        EnrollmentStudent(enrollmentId: id, security: security?.toDomain() ?? .placeholder, status: status, expireAt: expire_at, student: student.toDomain(), location: location, createdAt: created_at)
    }
}

extension GetStudentFilterRequest {
    func toRequestDTO() -> GetStudentsFilterRequestDTO {
        GetStudentsFilterRequestDTO(fieldStatus: fieldStatus)
    }
}

extension GetStudents {
    func toRequest() -> GetStudentsRequest {
        GetStudentsRequest(courseId: 1, filters: filters.toRequestDTO())
    }
}

extension DeleteFolderFilterRequest {
    func toRequestDTO() -> DeleteFolderFilterRequestDTO {
        DeleteFolderFilterRequestDTO(fieldId: fieldId, uuid: uuid)
    }
}

extension DeleteFolderDTO {
    func toRequest() -> DeleteFolderRequest {
        DeleteFolderRequest(folderId: -1, filters: filters.toRequestDTO())
    }
}

extension DeleteCourseFilterRequest {
    func toRequestDTO() -> DeleteCourseFilterRequestDTO {
        DeleteCourseFilterRequestDTO(fieldId: fieldId, uuid: uuid)
    }
}

extension DeleteCourseDTO {
    func toRequest() -> DeleteCourseRequest {
        DeleteCourseRequest(courseId: -1, filters: filters.toRequestDTO())
    }
}

extension CreateGroup {
    func toRequest() -> CreateGroupRequest {
        return CreateGroupRequest(name: name)
    }
}
