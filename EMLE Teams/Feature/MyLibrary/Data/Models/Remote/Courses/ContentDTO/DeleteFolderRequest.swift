//
//  DeleteFolderRequest.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 20/08/2024.
//

import Foundation
import EMLECore

class DeleteFolderRequest: CustomRequest {
    var endPoint: APIEndPoint { .deleteFolder }
    var method: RequestMethod { .delete }
    
    var url: String { String(format: MainCloudConfig.apiUrl + endPoint.value, folderId) }
    
    var parameters: Parameters? {
        let parameters = filters.parameters
        
        return parameters.isEmpty ? nil : parameters
    }
    
    let filters: DeleteFolderFilterRequestDTO
    var folderId: Int
    
    init(folderId: Int, filters: DeleteFolderFilterRequestDTO) {
        self.folderId = folderId
        self.filters = filters
    }
    
    func encode(to encoder: any Encoder) throws { }
}
