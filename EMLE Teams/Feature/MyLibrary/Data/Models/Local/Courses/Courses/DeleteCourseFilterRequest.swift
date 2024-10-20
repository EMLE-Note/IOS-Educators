//
//  DeleteCourseFilterRequest.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 21/08/2024.
//

import Foundation

struct DeleteCourseFilterRequest:Codable {
    var fieldId: [String]
    var uuid: [String]
}

extension DeleteCourseFilterRequest {
    static let empty = DeleteCourseFilterRequest(fieldId: [], uuid: [])
}
