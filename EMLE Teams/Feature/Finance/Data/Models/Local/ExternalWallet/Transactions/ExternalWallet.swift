//
//  ExternalWallet.swift
//  EMLE Teams
//
//  Created by iOSAYed on 20/07/2024.
//

import Foundation
import EMLECore

struct ExternalWallet: Codable, Identifiable, Hashable {
    
    var id: UUID = .init()
    let externalWalletId: Int
    let contentType: String
    let enrollment: Enrollment
    let receivable: Secretary
    let amount: Double
    let createdAt: String

    init(externalWalletId: Int, contentType: String, enrollment: Enrollment, receivable: Secretary, amount: Double, createdAt: String) {
        self.externalWalletId = externalWalletId
        self.contentType = contentType
        self.enrollment = enrollment
        self.receivable = receivable
        self.amount = amount
        self.createdAt = createdAt
    }
    
   
    
    var createdAtDate:String {
        return createdAt.toDayMonthYearWithTime() ?? ""
    }
    
    var progress: String {
        let paidAmount = amount
        let totalPrice = enrollment.price
        let progress = (paidAmount / totalPrice) * 100
        return "\(progress.stringTwoDecimalDigit) %"
    }
    
    var amountWithCurrency: String {
        let currancyCode = SharedData.shared.currancy.code ?? ""
        return "\(amount.stringTwoDecimalDigit) \(currancyCode)"
    }
    
    static func == (lhs: ExternalWallet, rhs: ExternalWallet) -> Bool {
        return lhs.id == rhs.id &&
               lhs.externalWalletId == rhs.externalWalletId &&
               lhs.contentType == rhs.contentType &&
               lhs.amount == rhs.amount &&
               lhs.createdAt == rhs.createdAt
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(externalWalletId)
        hasher.combine(contentType)
        hasher.combine(amount)
        hasher.combine(createdAt)
    }
}
extension ExternalWallet {
    static let placeholder = ExternalWallet(externalWalletId: 0, contentType: "Course", enrollment: .placeholder, receivable: .placeholder, amount: 0, createdAt: "")
}

extension [ExternalWallet] {
    static let placeholder: [ExternalWallet] = {
        var placeholder: [ExternalWallet] = []
        
        for i in 0..<5 {
            placeholder.append(ExternalWallet(externalWalletId: 0, contentType: "course", enrollment: .placeholder, receivable: .placeholder, amount: 1000, createdAt: "2024-07-19T19:54:51.000000Z"))
        }
        
        return placeholder
    }()
}
