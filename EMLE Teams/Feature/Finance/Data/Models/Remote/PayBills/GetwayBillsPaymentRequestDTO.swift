//
//  GetwayBillsPaymentRequestDTO.swift
//  EMLE Teams
//
//  Created by Mustafa Merza on 7/14/24.
//

import EMLECore

struct GetwayBillsPaymentRequestDTO: RequestDTO {
    
    let team_bill_id :Int
    let payment_method_id :Int
}
