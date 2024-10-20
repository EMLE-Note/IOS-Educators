//
//  GetContentFilterRequest.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 17/08/2024.
//

import Foundation

struct GetContentFilterRequest: Codable {
    var fieldId: [String]
    var uuid: [String]
}

extension GetContentFilterRequest {
    static let empty = GetContentFilterRequest(fieldId: [], uuid: [])
}
