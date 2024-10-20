//
//  GetCoursesFilterRequest.swift
//  EMLE Teams
//
//  Created by iOSAYed on 16/08/2024.
//

import Foundation

struct GetCoursesFilterRequest {
    var fieldId: [String]
    var fieldName: [String]
    var teamId: [String]
    var teamName: [String]
    var uuid: [String]
    var institutionName: [String]
    var institutionId: [String]
    var search: [String]
    var sort: [String]
}

extension GetCoursesFilterRequest {
    static let empty = GetCoursesFilterRequest(fieldId: [], fieldName: [], teamId: [], teamName: [], uuid: [], institutionName: [], institutionId: [], search: [], sort: [])
}
