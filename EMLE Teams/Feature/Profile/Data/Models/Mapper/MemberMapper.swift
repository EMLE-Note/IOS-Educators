//
//  MemberMapper.swift
//  EMLE Teams
//
//  Created by iOSAYed on 20/09/2024.
//

import EMLECore
import Foundation

extension GetMemberResponseDTO {
    func toMemberList() -> [Member] {
        return data.toDomain()
    }
}

extension MemberDTO {
    func toDomain() -> Member {
        var imageUrl: ImageUrl? = nil

        if let image {
            imageUrl = ImageUrl(urlString: image)
        }
        return Member(memberId: id, name: name, image: imageUrl, mobileCode: mobile_code, mobile: mobile, role: role, isInstructor: is_instructor, status: status, invitationStatus: invitation_status, team: team, teamID: team_id, createdAt: created_at, updatedAt: updated_at)
    }
}

extension [MemberDTO] {
    func toDomain() -> [Member] {
        try map { $0.toDomain() }
    }
}

extension SearchStaffResponseDTO {
    func toDomain() -> SearchStaffResponse {
        var imageUrl: ImageUrl? = nil

        if let image {
            imageUrl = ImageUrl(urlString: image)
        }
        return SearchStaffResponse(id: id, type: type, name: name, image: imageUrl, registerStatus: register_status, registerStatusNumeric: register_status_numeric)
    }
}

extension SearchStaffParameter {
    func toRequest() -> SearchStaffRequest {
        SearchStaffRequest(data: data)
    }
}

extension EnrollmentCourse {
    func toRequest() -> EnrollmentCourseManualRequest {
        EnrollmentCourseManualRequest(dto: self)
    }
}

extension EnrollmentCourse {
    func toRequest() -> EnrollmentQBankManualRequest {
        EnrollmentQBankManualRequest(dto: self)
    }
}

extension EnrollmentCourse {
    func toRequest() -> EnrollmentEBookManualRequest {
        EnrollmentEBookManualRequest(dto: self)
    }
}

extension EnrollmentCourseParameter {
    func toRequest() -> EnrollmentCourseGroupManualRequest {
        EnrollmentCourseGroupManualRequest(data: data)
    }
}

extension EnrollmentMassCourse {
    func toRequest() -> EnrollmentMassCourseDTO {
        EnrollmentMassCourseDTO(course_id: courseId, student_id: studentId, paid_amount: paidAmount, price: price)
    }
}

extension [EnrollmentMassCourse] {
    func toDomain() throws -> [EnrollmentMassCourseDTO] {
        map { $0.toRequest() }
    }
}
