//
//  EnrollmentMapper.swift
//  EMLE Teams
//
//  Created by iOSAYed on 11/08/2024.
//

import Foundation
import EMLECore


extension GetEnrollmentResponseDTO {
    func toDomain() throws -> EnrollmentResponseDomain {
        let content = try data.toDomain()
             
        return EnrollmentResponseDomain(enrollments: content , pagination: pagination.toDomain(content: content))
         }
    }

extension [EnrollmentResponseDTO] {
    func toDomain() throws -> [Enrollment] {
        try map { try $0.toDomain() }
    }
}


extension EnrollmentResponseDTO {
    func toDomain() throws -> Enrollment {
        Enrollment(enrollmentId: id, status: status, type: type, price: price, remained: remained, content: content.toDomain(), student: student.toDomain(), expireAt: expire_at, createdAt: created_at)
    }
}

extension EnrollmentContentFilter {
    func toRequestDTO() -> GetEnrollmentRequestDTO {
        GetEnrollmentRequestDTO(enrollmentType: enrollmentType, remained: remained, search: search, sort: sort)
    }
}

extension GetEnrollment {
    func toRequest() -> GetEnrollmentRequest {
        GetEnrollmentRequest(filters: filters.toRequestDTO())
    }
}
