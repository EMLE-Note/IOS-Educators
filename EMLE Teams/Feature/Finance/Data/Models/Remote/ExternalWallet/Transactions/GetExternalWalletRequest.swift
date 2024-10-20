//
//  GetExternalWalletRequest.swift
//  EMLE Teams
//
//  Created by iOSAYed on 20/07/2024.
//

import Foundation
import EMLECore

class GetExternalWalletRequest: CustomRequest {
    var endPoint: APIEndPoint { .getExternalWallet }
    
    var parameters: Parameters? {
        let parameters = filters.parameters
        
        return parameters.isEmpty ? nil : parameters
    }
    
    let filters: GetExternalWalletFilterRequestDTO
    
    init(filters: GetExternalWalletFilterRequestDTO) {
        self.filters = filters
    }
    
    func encode(to encoder: any Encoder) throws { }
}
