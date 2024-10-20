//
//  BillsPaymentMapper.swift
//  EMLE Teams
//
//  Created by iOSAYed on 10/07/2024.
//

import Foundation

extension BillsPaymentResponseDTO {
    func toDomain() -> BillsPayment {
        BillsPayment(paymentURL: payment_url)
    }
}
