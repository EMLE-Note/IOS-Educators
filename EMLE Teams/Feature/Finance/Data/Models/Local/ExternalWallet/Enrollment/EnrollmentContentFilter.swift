//
//  EnrollmentContentFilter.swift
//  EMLE Teams
//
//  Created by iOSAYed on 11/08/2024.
//

import Foundation

struct EnrollmentContentFilter:Codable {
    var enrollmentType: [String]
    var remained: [String]
    var materialType: [String]
    var search: [String]
    var sort: [String]
}

extension EnrollmentContentFilter {
    static let empty = EnrollmentContentFilter(enrollmentType: [],remained:[], materialType: [], search: [],sort: [])
}
