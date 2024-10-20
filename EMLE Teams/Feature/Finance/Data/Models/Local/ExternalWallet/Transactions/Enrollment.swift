//
//  Enrollment.swift
//  EMLE Teams
//
//  Created by iOSAYed on 20/07/2024.
//

import Foundation

struct Enrollment: Codable,Identifiable, Hashable {
    let id = UUID()
    let enrollmentId, status, type: Int
    let price, remained: Double
    let content: EnrollmentContent
    let student: Student
    let expireAt: String?
    let createdAt: String
    
    var createdAtDate:String {
        return createdAt.toDayMonthYearWithTime() ?? ""
    }
    
    var amountWithCurrency: String {
        let currancyCode = SharedData.shared.currancy.code ?? ""
        return "\(paidAmount) \(currancyCode)"
    }
    
    var paidAmount:String {
        let paidAmount = price - remained
        return "\(paidAmount.stringTwoDecimalDigit)"
    }
    
    var progress: String {
        let paidAmount = price - remained
        let totalPrice = price
        let progress = (paidAmount / totalPrice) * 100
        return "\(progress.stringTwoDecimalDigit) %"
    }
    
    var isDeactivate:Bool {
        status == 1 ? false : true
    }
    
    var enrollmentType:EnrollmentType? {
        switch type {
        case 1:
            return .Automated
        case 2:
            return .Manual
        case 3:
            return .Request
        default:
            return nil
        }
    }
    
    static func == (lhs: Enrollment, rhs: Enrollment) -> Bool {
        return lhs.id == rhs.id &&
               lhs.enrollmentId == rhs.enrollmentId &&
               lhs.type == rhs.type &&
               lhs.price == rhs.price &&
               lhs.createdAt == rhs.createdAt
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(enrollmentId)
        hasher.combine(type)
        hasher.combine(price)
        hasher.combine(createdAt)
    }
}

extension Enrollment {
    static let placeholder = Enrollment(enrollmentId: 0, status: 0, type: 0, price: 0, remained: 0, content: .placeholder, student: .placeholder, expireAt: "", createdAt: "")
}

extension [Enrollment] {
    static let placeholder: [Enrollment] = {
        var placeholder: [Enrollment] = []
        
        for i in 0..<5 {
            placeholder.append(Enrollment(enrollmentId: 0, status: 0, type: 0, price: 1000, remained: 100, content: .placeholder, student: .placeholder, expireAt: "", createdAt: "2024-07-19T19:54:51.000000Z")
            )
        }
        
        return placeholder
    }()
}
