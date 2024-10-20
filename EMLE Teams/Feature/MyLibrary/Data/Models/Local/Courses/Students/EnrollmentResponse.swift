//
//  EnrollmentResponse.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 19/08/2024.
//

import Foundation
import EMLECore

struct EnrollmentResponse {
    let enrollments: [EnrollmentStudent]
    let pagination: PaginatedContent<[EnrollmentStudent]>
}
