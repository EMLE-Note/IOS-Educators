//
//  ConfirmTransactionRequestDTO.swift
//  EMLE Teams
//
//  Created by iOSAYed on 07/08/2024.
//

import Foundation
import EMLECore

class ConfirmTransactionRequestDTO: CustomRequest {
    var method: RequestMethod { .post }
    var endPoint: APIEndPoint {.confirmTransactionRequest}
    var url: String { String(format: MainCloudConfig.apiUrl + endPoint.value, transactionId) }

    
    let transactionId: Int
    
    init(transactionId: Int) {
        self.transactionId = transactionId
    }
}
