//
//  DeleteFolder.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 20/08/2024.
//

import Foundation

struct DeleteFolderFilterRequest: Codable {
    var fieldId: [String]
    var uuid: [String]
}

extension DeleteFolderFilterRequest {
    static let empty = DeleteFolderFilterRequest(fieldId: [], uuid: [])
}
