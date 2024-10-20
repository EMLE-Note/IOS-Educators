//
//  DeleteFolderDTO.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 20/08/2024.
//

import Foundation

struct DeleteFolderDTO {
    let filters: DeleteFolderFilterRequest
}

extension DeleteFolderDTO {
    static let empty = DeleteFolderDTO(filters: .empty)
}
