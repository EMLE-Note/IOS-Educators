//
//  DeleteCourseDTO.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 21/08/2024.
//

import Foundation

struct DeleteCourseDTO {
    let filters: DeleteCourseFilterRequest
}

extension DeleteCourseDTO {
    static let empty = DeleteCourseDTO(filters: .empty)
}
