//
//  InvitationListRequest.swift
//  EMLE Teams
//
//  Created by iOSAYed on 27/10/2024.
//

import Foundation
import EMLECore

class InvitationListRequest: CustomRequest {
    
    var endPoint: APIEndPoint { .teamInvitationsList }
    
    var method: RequestMethod { .get }
}
