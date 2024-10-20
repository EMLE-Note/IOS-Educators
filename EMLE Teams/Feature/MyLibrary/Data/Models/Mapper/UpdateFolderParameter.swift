//
//  UpdateFolderParameter.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 20/08/2024.
//

import Foundation

struct UpdateFolderParameter: Codable {
    var folderId: Int
    var isVisible: Int?
    var name: String?
}

extension UpdateFolderParameter {
    func toRequest() -> UpdateFolderRequest {
        return UpdateFolderRequest(folderId: folderId, isVisible: isVisible, name: name)
    }
}

