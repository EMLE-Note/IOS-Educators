//
//  FinanceAPI.swift
//  EMLE Teams
//
//  Created by iOSAYed on 02/07/2024.
//

import Foundation
import EMLECore

protocol FinanceAPIProtocol: APIProtocol {
    func getFinanceDataRequest(request:GetFinanceRequestDTO) throws -> APIDataPublisher
    func billsGetwayPaymentDataRequest(request:GetwayBillsPaymentRequest) throws -> APIDataPublisher
    func getExternalWallet(request:GetExternalWalletRequest) throws -> APIDataPublisher
    func getSecretary(request:GetSecretaryRequest) throws -> APIDataPublisher
    func getTransactionsRequests(request:GetTransactionsRequest) throws -> APIDataPublisher
    func postTransactionRequest(transactionId: Int) throws -> APIDataPublisher
    func deleteTransactionRequest(transactionId: Int) throws -> APIDataPublisher
    func getEnrollmentCourses(request:GetEnrollmentRequest) throws -> APIDataPublisher
    func declineCourse(enrollmentId: Int,paidAmount:String) throws -> APIDataPublisher

}

class FinanceAPI: FinanceAPIProtocol {
 
    var networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    func getFinanceDataRequest(request: GetFinanceRequestDTO) throws -> APIDataPublisher {
        return try sendTeamAuthorizedAPICall(request: request)
    }
    
    func billsGetwayPaymentDataRequest(request: GetwayBillsPaymentRequest) throws -> APIDataPublisher {
        let requestWithTeamId = request
        return try sendTeamAuthorizedAPICall(request: requestWithTeamId)
    }
    
    func getExternalWallet(request: GetExternalWalletRequest) throws -> APIDataPublisher {
        return try sendTeamAuthorizedAPICall(request: request)
    }
    
    func getSecretary(request:GetSecretaryRequest) throws -> APIDataPublisher {
        return try sendTeamAuthorizedAPICall(request:request)
    }
    
    func getTransactionsRequests(request: GetTransactionsRequest) throws -> APIDataPublisher {
        return try sendTeamAuthorizedAPICall(request: request)
    }
    
    func postTransactionRequest(transactionId: Int) throws -> APIDataPublisher {
            let request = ConfirmTransactionRequestDTO(transactionId: transactionId)
            return try sendTeamAuthorizedAPICall(request: request)
        }

        func deleteTransactionRequest(transactionId: Int) throws -> APIDataPublisher {
            let request = DeleteTransactionRequestDTO(transactionId: transactionId)
            return try sendTeamAuthorizedAPICall(request: request)
        }
    
    func getEnrollmentCourses(request: GetEnrollmentRequest) throws -> APIDataPublisher {
        return try sendTeamAuthorizedAPICall(request: request)
    }
    
    func declineCourse(enrollmentId: Int,paidAmount:String) throws -> APIDataPublisher {
        let request = DeclineCourseRequest(enrollmentId: enrollmentId, paidAmount: paidAmount)
        return try sendTeamAuthorizedAPICall(request: request)
    }
}
