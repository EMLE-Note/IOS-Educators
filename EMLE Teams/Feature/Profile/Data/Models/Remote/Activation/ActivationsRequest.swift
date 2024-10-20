//
//  ActivationsRequest.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 12/10/2024.
//

import Foundation
import EMLECore

class ActivationsRequest: CustomRequest {
    
    var endPoint: APIEndPoint { .getActivation }
    
    var method: RequestMethod { .get }
    
}
