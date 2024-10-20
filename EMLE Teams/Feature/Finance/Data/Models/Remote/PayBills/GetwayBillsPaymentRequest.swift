//
//  GetwayBillsPaymentRequest.swift
//  EMLE Teams
//
//  Created by iOSAYed on 10/07/2024.
//

import EMLECore

class GetwayBillsPaymentRequest: CustomRequest {
    
    var endPoint: APIEndPoint { .getwayBillsPayment }
    
    var method: RequestMethod { .post }
    
    var dto: RequestDTO? { _dto }
    
    let _dto: GetwayBillsPaymentRequestDTO
    
    
    init(teamBillId:Int,paymentMethodId:Int) {
        _dto = GetwayBillsPaymentRequestDTO(team_bill_id: teamBillId,
                                            payment_method_id: paymentMethodId)
    }
}
