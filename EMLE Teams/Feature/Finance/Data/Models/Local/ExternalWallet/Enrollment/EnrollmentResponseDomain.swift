//
//  EnrollmentResponseDomain.swift
//  EMLE Teams
//
//  Created by iOSAYed on 11/08/2024.
//

import Foundation
import EMLECore

struct EnrollmentResponseDomain {
    let enrollments: [Enrollment]
    let pagination: PaginatedContent<[Enrollment]>
}
