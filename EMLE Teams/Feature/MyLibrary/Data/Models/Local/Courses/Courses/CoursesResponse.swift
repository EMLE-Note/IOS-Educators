//
//  CoursesResponse.swift
//  EMLE Teams
//
//  Created by iOSAYed on 16/08/2024.
//

import Foundation
import EMLECore

struct CoursesResponse {
    let courses: [Course]
    let pagination: PaginatedContent<[Course]>
}
