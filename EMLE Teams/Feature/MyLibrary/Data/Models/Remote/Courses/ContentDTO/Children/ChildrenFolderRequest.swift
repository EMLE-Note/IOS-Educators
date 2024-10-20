//
//  ChildrenFolderRequest.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 20/08/2024.
//

import Foundation
import EMLECore

class ChildrenFolderRequest: CustomRequest {
    var endPoint: APIEndPoint { .getChilderFolder }
    
    var url: String { String(format: MainCloudConfig.apiUrl + endPoint.value, folderId) }
    
    let folderId: Int
    
    init(folderId: Int) {
        self.folderId = folderId
    }
    
}
