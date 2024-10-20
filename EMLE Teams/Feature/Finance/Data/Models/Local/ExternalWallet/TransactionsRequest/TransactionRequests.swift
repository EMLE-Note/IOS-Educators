//
//  TransactionRequests.swift
//  EMLE Teams
//
//  Created by iOSAYed on 06/08/2024.
//

import Foundation
import EMLECore

struct TransactionRequests: Codable,Identifiable,Hashable {
   
    
    let id: UUID = UUID()
    let transactionId: Int
    let staff: Staff
    let amount: Double
    let image: ImageUrl?
    let createdAt: String
    
    
    var createdAtDate:String {
        return createdAt.toDayMonthYearWithTime() ?? ""
    }
    
    var amountWithCurrency: String {
        let currancyCode = SharedData.shared.currancy.code ?? ""
        return "\(amount.stringTwoDecimalDigit) \(currancyCode)"
    }
    
    static func == (lhs: TransactionRequests, rhs: TransactionRequests) -> Bool {
       return lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension TransactionRequests {
    static let placeholder = TransactionRequests(transactionId: 0, staff: .placeholder, amount: 0.0, image: nil, createdAt: "")
}
