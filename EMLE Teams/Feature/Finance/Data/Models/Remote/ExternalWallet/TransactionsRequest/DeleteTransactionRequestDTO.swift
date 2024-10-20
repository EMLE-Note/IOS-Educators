//
//  DeleteTransactionRequestDTO.swift
//  EMLE Teams
//
//  Created by iOSAYed on 07/08/2024.
//

import Foundation
import EMLECore

class DeleteTransactionRequestDTO: CustomRequest {
    var method: RequestMethod { .delete }
    var endPoint: APIEndPoint {.confirmTransactionRequest}
    var url: String { String(format: MainCloudConfig.apiUrl + endPoint.value, transactionId) }
    
    let transactionId: Int
    
    init(transactionId: Int) {
        self.transactionId = transactionId
    }
}
