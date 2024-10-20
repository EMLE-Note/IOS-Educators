//
//  GetwayBillsPaymentUseCase.swift
//  EMLE Teams
//
//  Created by iOSAYed on 10/07/2024.
//

import Foundation

class GetwayBillsPaymentUseCase {
    private let repository: FinanceRepositoryProtocol
    
    init(repository: FinanceRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(teamId:String?, params:GetwayBillsPaymentParameter) throws -> GetwayBillsPaymentDataPublisher {
        try repository.GetwayBillsPayment(params: params)
    }
}
