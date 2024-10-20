//
//  UpdateEnrollmentStudentParameter.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 19/08/2024.
//

import Foundation


extension UpdateEnrollmentStudentParameter {
    func toRequest() -> UpdateEnrollmentStudentRequest {
        return UpdateEnrollmentStudentRequest(enrollmentId: enrollmentId, status: status, security: security, locationId: locationId, expireAt: expireAt)
    }
}

extension UpdateEnrollmentStudent {
    func toRequestDTO() -> UpdateEnrollmentStudentDTO {
        return UpdateEnrollmentStudentDTO(status: status, security: security?.toRequestDTO(), locationId: locationId, expireAt: expireAt)
    }
}
