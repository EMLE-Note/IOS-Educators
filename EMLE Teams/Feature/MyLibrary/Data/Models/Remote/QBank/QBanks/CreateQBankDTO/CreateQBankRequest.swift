//
//  CreateQBankRequest.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 16/09/2024.
//

import Foundation
import EMLECore
import Alamofire

class CreateQBankRequest: CustomRequest {

    var endPoint: APIEndPoint { .createQBank }
    var method: RequestMethod { .post }
    var url: String { String(format: MainCloudConfig.apiUrl + endPoint.value) }
    
    var formData: FormData? {
        let parameters = data.formData
        
        return parameters.isEmpty ? nil : parameters
    }
    
    let data: CreateQBankFromRequestDTO

    
    init(data: CreateQBankFromRequestDTO) {
        self.data = data
    }
}
