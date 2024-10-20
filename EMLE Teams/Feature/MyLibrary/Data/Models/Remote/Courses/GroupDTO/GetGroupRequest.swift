//
//  GetGroupRequest.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 01/09/2024.
//

import Foundation
import EMLECore
import Alamofire

class GetGroupRequest: CustomRequest {

    var endPoint: APIEndPoint { .createGroup }
}
