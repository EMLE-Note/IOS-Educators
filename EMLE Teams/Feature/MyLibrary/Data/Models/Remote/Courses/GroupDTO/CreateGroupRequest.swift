//
//  CreateGroupRequest.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 31/08/2024.
//

import Foundation
import EMLECore
import Alamofire

class CreateGroupRequest: CustomRequest {

    var endPoint: APIEndPoint { .createGroup }
    var method: RequestMethod { .post }
    
    var dto: RequestDTO? { _dto }

    let _dto: CreateGroupDTO
    

    init(name: String) {
        _dto = CreateGroupDTO(name: name)
    }
}
