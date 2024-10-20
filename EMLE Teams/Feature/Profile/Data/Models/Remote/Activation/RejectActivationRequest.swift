//
//  RejectActivationRequest.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 13/10/2024.
//

import Foundation
import EMLECore

class RejectActivationRequest: CustomRequest {
    
    var endPoint: APIEndPoint { .rejectActivation }
    
    var url: String { String(format: MainCloudConfig.apiUrl + endPoint.value, activationID) }
    
    var method: RequestMethod { .delete }
    
    let activationID: Int
    
    init(activationID: Int) {
        self.activationID = activationID
    }
}
