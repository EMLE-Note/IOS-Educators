//
//  CoursesResponse.swift
//  EMLE Teams
//
//  Created by iOSAYed on 16/08/2024.
//

import Foundation
import EMLECore

class GetCoursesResponseDTO: Codable {
    let courses: [CourseDTO]
    let pagination: PaginationResponseDTO
}
