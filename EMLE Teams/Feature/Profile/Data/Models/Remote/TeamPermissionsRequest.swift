//
//  TeamPermissionsRequest.swift
//  EMLE Teams
//
//  Created by iOSAYed on 07/09/2024.
//

import Foundation
import EMLECore

class TeamPermissionsRequest: CustomRequest {
    
    var endPoint: APIEndPoint { .teamPermission }
    
    var method: RequestMethod { .get }
    
}
