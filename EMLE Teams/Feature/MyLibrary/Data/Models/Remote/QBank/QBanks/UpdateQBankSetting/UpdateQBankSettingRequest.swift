//
//  UpdateQBankSettingRequest.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 25/09/2024.
//

import Foundation
import EMLECore
import Alamofire

class UpdateQBankSettingRequest: CustomRequest {

    var endPoint: APIEndPoint { .updateQBank }
    var method: RequestMethod { .post }
    var url: String { String(format: MainCloudConfig.apiUrl + endPoint.value, qbankId) }
    
    var formData: FormData? {
        let parameters = data.formData
        
        return parameters.isEmpty ? nil : parameters
    }
    
    let data: UpdateQBankFormDataRequestDTO

    var qbankId: Int
    
    init(qbankId: Int, data: UpdateQBankFormDataRequestDTO) {
        self.qbankId = qbankId
        self.data = data
    }
}
