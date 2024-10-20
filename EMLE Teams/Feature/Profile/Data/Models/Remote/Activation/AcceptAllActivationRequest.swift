//
//  AcceptAllActivationRequest.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 13/10/2024.
//

import Foundation
import EMLECore

class AcceptAllActivationRequest: CustomRequest {
    
    var endPoint: APIEndPoint { .acceptAllActivation }
    
    var url: String { String(format: MainCloudConfig.apiUrl + endPoint.value) }
    
    var method: RequestMethod { .post }
    
    var dto: RequestDTO? { _dto }

    private let _dto: ActivationAllDTO
    
    init(activationID: [Int]) {
        self._dto = ActivationAllDTO(id: activationID)
    }
}
