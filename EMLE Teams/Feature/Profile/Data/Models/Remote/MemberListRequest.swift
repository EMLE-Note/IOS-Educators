//
//  MemberListRequest.swift
//  EMLE Teams
//
//  Created by iOSAYed on 20/09/2024.
//

import Foundation
import EMLECore

class MemberListRequest: CustomRequest {
    
    var endPoint: APIEndPoint { .memberList }
    
    var method: RequestMethod { .get }
    
}
