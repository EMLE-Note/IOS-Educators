//
//  DeleteGroupResquest.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 01/09/2024.
//

import Foundation
import EMLECore

class DeleteGroupResquest: CustomRequest {

    var endPoint: APIEndPoint { .deleteGroup }
    
    var method: RequestMethod { .delete }
    
    var url: String { String(format: MainCloudConfig.apiUrl + endPoint.value, groupId) }
    
    var groupId: Int
    
    init(groupId: Int) {
        self.groupId = groupId
    }
}
