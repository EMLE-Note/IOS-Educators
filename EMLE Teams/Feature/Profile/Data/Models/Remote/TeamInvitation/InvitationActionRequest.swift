//
//  InvitationActionRequest.swift
//  EMLE Teams
//
//  Created by iOSAYed on 27/10/2024.
//

import Foundation
import EMLECore

class InvitationActionRequest: CustomRequest {
    
    var endPoint: APIEndPoint { .teamInvitationsAction }
    
    var url: String { String(format: MainCloudConfig.apiUrl + endPoint.value, invitationID) }
    
    var method: RequestMethod { .post }
    
    var parameters: Parameters? {
        let parameters = params.parameters
        
        return parameters.isEmpty ? nil : parameters
    }
    
    let invitationID: Int
    let params: InvitationActionParametersDTO
    
    init(invitationID: Int,params:InvitationActionParametersDTO) {
        self.invitationID = invitationID
        self.params = params
    }
}
