//
//  GetQBankRequest.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 02/09/2024.
//

import Foundation
import EMLECore

class GetQBankRequest: CustomRequest {
    var endPoint: APIEndPoint { .createQBank }
    
    var parameters: Parameters? {
        let parameters = filters.parameters
        
        return parameters.isEmpty ? nil : parameters
    }
    
    let filters: GetQBankFilterRequestDTO
    
    init(filters: GetQBankFilterRequestDTO) {
        self.filters = filters
    }
    
    func encode(to encoder: any Encoder) throws { }
}
