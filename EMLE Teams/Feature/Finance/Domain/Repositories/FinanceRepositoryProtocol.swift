//
//  FinanceRepositoryProtocol.swift
//  EMLE Teams
//
//  Created by iOSAYed on 03/07/2024.
//

import Foundation
import EMLECore

protocol FinanceRepositoryProtocol: RepositoryProtocol {
    
    func getFinanceData() throws -> FinanceDataPublisher
    func GetwayBillsPayment(params:GetwayBillsPaymentParameter) throws -> GetwayBillsPaymentDataPublisher
    func getExternalWallet(params:GetExternalWallet) throws -> GetExternalWalletDataPublisher
    func getSecretay() throws -> GetSecretaryDataPublisher
    func getTransactionsRequests() throws -> GetTransactionsRequestsDataPublisher
    func confirmTransaction(transactionId: Int) throws -> ConfirmTransactionsRequestsDataPublisher
    func deleteTransaction(transactionId: Int) throws -> ConfirmTransactionsRequestsDataPublisher 
    func getEnrollmentCourses(params:GetEnrollment) throws -> GetEnrollmentCoursesDataPublisher
    
    func declineCourse(enrollmentId: Int, paidAmount: String) throws -> PostDeclineCourseDataPublisher
}
