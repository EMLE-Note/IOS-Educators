//
//  UpdateQBankRequestDTO.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 25/09/2024.
//

import Foundation
import EMLECore

class GetSettingQBankRequest: CustomRequest {
        
    var endPoint: APIEndPoint { .getQBank }
    
    var url: String { String(format: MainCloudConfig.apiUrl + endPoint.value, qbankId) }
    
    var parameters: Parameters? {
        let parameters = filters.parameters
        
        return parameters.isEmpty ? nil : parameters
    }
    
    let qbankId: Int
    let filters: GetQBankSettingFilterRequestDTO
    
    init(qbankId: Int, filters: GetQBankSettingFilterRequestDTO) {
        self.qbankId = qbankId
        self.filters = filters
    }

    func encode(to encoder: any Encoder) throws { }
}
