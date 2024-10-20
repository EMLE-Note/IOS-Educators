//
//  GetEnrollment.swift
//  EMLE Teams
//
//  Created by iOSAYed on 11/08/2024.
//

import Foundation

struct GetEnrollment {
    let filters: EnrollmentContentFilter
}

extension GetEnrollment {
    static let empty = GetEnrollment(filters: .empty)
}
