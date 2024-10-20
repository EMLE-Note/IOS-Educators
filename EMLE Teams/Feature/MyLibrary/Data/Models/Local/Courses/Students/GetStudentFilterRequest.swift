//
//  GetStudentFilterRequest.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 19/08/2024.
//

import Foundation

struct GetStudentFilterRequest:Codable {
    var fieldStatus: [String]
}

extension GetStudentFilterRequest {
    static let empty = GetStudentFilterRequest(fieldStatus: [])
}
