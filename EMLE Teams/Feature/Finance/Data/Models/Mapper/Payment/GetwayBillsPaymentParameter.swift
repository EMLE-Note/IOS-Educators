//
//  GetwayBillsPaymentRequest.swift
//  EMLE Teams
//
//  Created by iOSAYed on 10/07/2024.
//

import Foundation

struct GetwayBillsPaymentParameter {
    let teamBillId: Int
    let paymentMethodId: Int
}

extension GetwayBillsPaymentParameter {
    func toRequest() -> GetwayBillsPaymentRequest {
        return GetwayBillsPaymentRequest(
            teamBillId: teamBillId,
            paymentMethodId: paymentMethodId
        )
    }
}
