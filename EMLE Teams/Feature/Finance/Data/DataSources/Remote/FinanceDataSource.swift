//
//  FinanceDataSource.swift
//  EMLE Teams
//
//  Created by iOSAYed on 03/07/2024.
//

import Foundation
import Combine
import EMLECore

typealias FinanceDataResponsePublisher = ResponsePublisher<GetFinanceResponseDTO>
typealias GetwayBillsPaymentResponsePublisher = ResponsePublisher<BillsPaymentResponseDTO>
typealias GetExternalWalletResponsePublisher = ResponsePublisher<GetExternallWalletResponseDTO>
typealias GetSecretaryResponsePublisher = ResponsePublisher<[SecretaryDTO]>
typealias GetTransactionsRequestsResponsePublisher = ResponsePublisher<[GetTransactionsRequestDTO]>
typealias ConfrimTransactionRequestResponsePublisher = ResponsePublisher<TransactionDeleteConfirmModelDTO>
typealias GetEnrollmentCoursesResponsePublisher = ResponsePublisher<GetEnrollmentResponseDTO>
typealias DeclineCourseResponsePublisher = ResponsePublisher<DeclineCourseDTO>

protocol FinanceDataSourceProtocol: RemoteDataSourceProtocol {
    func getFinance() throws -> FinanceDataResponsePublisher
    func getwayBillsPayment(params:GetwayBillsPaymentParameter) throws -> GetwayBillsPaymentResponsePublisher
    func getExternalWallet(params:GetExternalWallet) throws -> GetExternalWalletResponsePublisher
    func getSecretary()  throws -> GetSecretaryResponsePublisher
    func getTransactionsRequests() throws -> GetTransactionsRequestsResponsePublisher
    func confirmTransaction(transactionId: Int) throws -> ConfrimTransactionRequestResponsePublisher
    func deleteTransaction(transactionId: Int) throws -> ConfrimTransactionRequestResponsePublisher
    func getEnrollmentCourses(params:GetEnrollment) throws -> GetEnrollmentCoursesResponsePublisher
    func declineCourse(enrollmentId: Int,paidAmount:String) throws -> DeclineCourseResponsePublisher
}

class FinanceDataSource: FinanceDataSourceProtocol {
    
    private let api: FinanceAPIProtocol
    
    init(api: FinanceAPIProtocol) {
        self.api = api
    }
    
    func getFinance() throws -> FinanceDataResponsePublisher {
        try api.getFinanceDataRequest(request: GetFinanceRequestDTO())
            .toResponsePublisher()
    }
    
    func getwayBillsPayment(params:GetwayBillsPaymentParameter) throws -> GetwayBillsPaymentResponsePublisher {
        try api.billsGetwayPaymentDataRequest(request: params.toRequest())
            .toResponsePublisher()
    }
    
    func getExternalWallet(params: GetExternalWallet) throws -> GetExternalWalletResponsePublisher {
        try api.getExternalWallet(request: params.toRequest())
            .toResponsePublisher()
    }
    
    func getSecretary() throws -> GetSecretaryResponsePublisher {
        try api.getSecretary(request: GetSecretaryRequest())
            .toResponsePublisher()
    }
    
    func getTransactionsRequests() throws -> GetTransactionsRequestsResponsePublisher {
        try api.getTransactionsRequests(request: GetTransactionsRequest())
            .toResponsePublisher()
    }
    
    func confirmTransaction(transactionId: Int) throws -> ConfrimTransactionRequestResponsePublisher {
          try api.postTransactionRequest(transactionId: transactionId)
            .toResponsePublisher()
      }

      func deleteTransaction(transactionId: Int) throws -> ConfrimTransactionRequestResponsePublisher{
          try api.deleteTransactionRequest(transactionId: transactionId)
              .toResponsePublisher()
      }
    
    func getEnrollmentCourses(params: GetEnrollment) throws -> GetEnrollmentCoursesResponsePublisher {
        try api.getEnrollmentCourses(request: params.toRequest())
            .toResponsePublisher()
    }
    
    func declineCourse(enrollmentId: Int,paidAmount:String) throws -> DeclineCourseResponsePublisher {
        try api.declineCourse(enrollmentId: enrollmentId, paidAmount: paidAmount)
            .toResponsePublisher()
    }
    
}
