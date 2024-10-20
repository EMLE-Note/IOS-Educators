//
//  GetStudents.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 19/08/2024.
//

import Foundation

struct GetStudents {
    let filters: GetStudentFilterRequest
}

extension GetStudents {
    static let empty = GetStudents(filters: .empty)
}
