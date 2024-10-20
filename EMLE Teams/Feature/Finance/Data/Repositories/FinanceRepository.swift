//
//  FinanceRepository.swift
//  EMLE Teams
//
//  Created by iOSAYed on 03/07/2024.
//

import Combine
import EMLECore
import Foundation

typealias FinanceDataPublisher = DomainPublisher<Finance>
typealias GetwayBillsPaymentDataPublisher = DomainPublisher<BillsPayment>
typealias GetExternalWalletDataPublisher = DomainPublisher<ExternalWalletResponseDomain>
typealias GetSecretaryDataPublisher = DomainPublisher<[Secretary]>
typealias GetTransactionsRequestsDataPublisher = DomainPublisher<[TransactionRequests]>
typealias ConfirmTransactionsRequestsDataPublisher = DomainPublisher<TransactionDeleteConfirmModel>
typealias GetEnrollmentCoursesDataPublisher = DomainPublisher<EnrollmentResponseDomain>
typealias PostDeclineCourseDataPublisher = DomainPublisher<DeclineCourse>

class FinanceRepository: FinanceRepositoryProtocol {
  
    private let dataSource: FinanceDataSourceProtocol
    
    init(dataSource: FinanceDataSourceProtocol) {
        self.dataSource = dataSource
    }
    
    func getFinanceData() throws -> FinanceDataPublisher {
        try dataSource.getFinance()
            .tryMap { $0.toDomainWrapper(with: $0.data?.toDomain()) }
            .mapError()
            .eraseToAnyPublisher()
    }
    
    func GetwayBillsPayment(params: GetwayBillsPaymentParameter) throws -> GetwayBillsPaymentDataPublisher {
        try dataSource.getwayBillsPayment(params: params)
            .tryMap { $0.toDomainWrapper(with: $0.data?.toDomain()) }
            .mapError()
            .eraseToAnyPublisher()
    }
    
    func getExternalWallet(params: GetExternalWallet) throws -> GetExternalWalletDataPublisher {
        try dataSource.getExternalWallet(params: params)
            .tryMap { try $0.toDomainWrapper(with: $0.data?.toDomain()) }
            .mapError()
            .eraseToAnyPublisher()
    }
    
    func getSecretay() throws -> GetSecretaryDataPublisher {
        try dataSource.getSecretary()
            .tryMap { try $0.toDomainWrapper(with: $0.data?.toDomain()) }
            .mapError()
            .eraseToAnyPublisher()
    }
    
    func getTransactionsRequests() throws -> GetTransactionsRequestsDataPublisher {
        try dataSource.getTransactionsRequests()
            .tryMap { try $0.toDomainWrapper(with: $0.data?.toDomain()) }
            .mapError()
            .eraseToAnyPublisher()
    }
    
    func confirmTransaction(transactionId: Int) throws -> ConfirmTransactionsRequestsDataPublisher {
        try dataSource.confirmTransaction(transactionId: transactionId)
            .tryMap { $0.toDomainWrapper(with: nil)}
            .mapError()
            .eraseToAnyPublisher()
    }

    func deleteTransaction(transactionId: Int) throws -> ConfirmTransactionsRequestsDataPublisher {
        try dataSource.deleteTransaction(transactionId: transactionId)
            .tryMap { $0.toDomainWrapper(with: nil)}
            .mapError()
            .eraseToAnyPublisher()
    }

    func getEnrollmentCourses(params: GetEnrollment) throws -> GetEnrollmentCoursesDataPublisher {
        try dataSource.getEnrollmentCourses(params: params)
            .tryMap { try $0.toDomainWrapper(with: $0.data?.toDomain()) }
                    .mapError()
                    .eraseToAnyPublisher()
    }
    
    func declineCourse(enrollmentId: Int, paidAmount: String) throws -> PostDeclineCourseDataPublisher {
        try dataSource.declineCourse(enrollmentId: enrollmentId, paidAmount: paidAmount)
            .tryMap { $0.toDomainWrapper(with: nil)}
            .mapError()
            .eraseToAnyPublisher()
    }
    
    
    
}
