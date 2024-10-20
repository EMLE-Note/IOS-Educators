//
//  FinanceDependancyManager.swift
//  EMLE Teams
//
//  Created by iOSAYed on 03/07/2024.
//

import Foundation
import EMLECore

class FinanceDependancyManager {
    
    let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
        
        initializeDependancies()
    }
    
    func initializeDependancies(){
        let api = FinanceAPI(networkManager: networkManager)
        let dataSource = FinanceDataSource(api: api)
        let financeRepository = FinanceRepository(dataSource: dataSource)
        
        @Provide var getFinanceUseCase = FinanceDataUseCase(repository: financeRepository)
        @Provide var getwayBillsPayment = GetwayBillsPaymentUseCase(repository: financeRepository)
        @Provide var externalWalletUseCase = ExternalWalletUseCase(repository: financeRepository)
        @Provide var secretaryUseCase = SecretaryUseCase(repository: financeRepository)
        @Provide var transactionsrequestsUseCase = TransactionsRequestsUseCase(repository: financeRepository)
        @Provide var enrollmentUseCase = EnrollmentUseCase(repository: financeRepository)
    }
    
}
