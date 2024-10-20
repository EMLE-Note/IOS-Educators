//
//  AcceptActivationRequest.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 13/10/2024.
//

import Foundation
import EMLECore

class AcceptActivationRequest: CustomRequest {
    
    var endPoint: APIEndPoint { .acceptActivation }
    
    var url: String { String(format: MainCloudConfig.apiUrl + endPoint.value, activationID) }
    
    var method: RequestMethod { .post }
    
    let activationID: Int
    
    init(activationID: Int) {
        self.activationID = activationID
    }
}
