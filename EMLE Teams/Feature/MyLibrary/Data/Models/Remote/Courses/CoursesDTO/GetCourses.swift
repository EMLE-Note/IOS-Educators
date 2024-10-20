//
//  GetCourses.swift
//  EMLE Teams
//
//  Created by iOSAYed on 16/08/2024.
//

import Foundation

struct GetCourses {
    let filters: GetCoursesFilterRequest
}

extension GetCourses {
    static let empty = GetCourses(filters: .empty)
}
