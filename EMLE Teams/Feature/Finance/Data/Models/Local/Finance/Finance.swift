//
//  Finance.swift
//  EMLE Teams
//
//  Created by iOSAYed on 02/07/2024.
//

import Foundation
import EMLECore

struct Finance: Codable {
    let balance, debts, externalWallet: Double?
    let currentDeal: CurrentDeal?
    let bills: Bills?
}

struct Bills: Codable {
    let status: Int?
    let total: Double?
    let current: Bill?
    let unpaid: [Bill]?
    
    static let placeholder = Bills(status: 0, total: 0, current: .placeholder, unpaid: [.placeholder])
}

struct Bill: Codable {
    let id: Int?
    let uuid: String?
    let data: MonitorBill?
    let price: Double?
    let status: Int?
    let currency: Currency?
    let dueDate, createdAt: String?
    
    var billState: BillStates? {
            guard let status = status else { return nil }
            return BillStates(rawValue: status)
        }
    var billDueDate:String {
        guard let dueDate = dueDate else {return ""}
        return dueDate.toDayMonthYear() ?? ""
    }
    
    var billDueDateWithDash:String {
        guard let dueDate = dueDate else {return ""}
        return dueDate.toDayMonthYearWithDash() ?? ""
    }
    
    var createdAtMonth:String {
        guard let createdAt = createdAt else {return ""}
        return createdAt.toMonthOnly() ?? ""
    }
    
    
    
    
    static let placeholder = Bill(id: 0, uuid: "", data: MonitorBill(students:MonitorBillItem(price: 0, value: 0),bandwidth: MonitorBillItem(price: 0, value: 0),storage: MonitorBillItem(price: 0, value: 0), tokens: TokenItem(price: "", value: 0)), price: 0, status: 0, currency: Currency(id: 0, code: "", name: ""), dueDate: "", createdAt: "")
}

struct MonitorBill: Codable {
    let students ,bandwidth,storage : MonitorBillItem?
    let tokens: TokenItem?
}

struct MonitorBillItem: Codable {
    let price: Double?
    let value: Double?
    
    var amount: String {
        guard let price = price?.toTwoDecimalDigit() , let currancy = SharedData.shared.currancy.code else{
            return ""
        }
        return "\(price) \(currancy) "
    }
    
    var total:String {
        guard let price = price, let value = value, let currancy = SharedData.shared.currancy.code else {return ""}
       let total =  price.multiply(by: value)
        return "\(total.stringTwoDecimalDigit) \(currancy)"
    }
}

struct TokenItem: Codable {
    let price: String?
    let value: Double?
    
    var amount: String {
        guard let price = price else{return "" }
        return price
    }
    
    var total:String {
        guard let price = price, let value = value, let currancy = SharedData.shared.currancy.code else {return ""}
        let total = ((Int(price) ?? 0) * Int(value))
        return "\(total) \(currancy)"
    }
}

struct Currency: Codable,Hashable {
    let id: Int?
    let code, name: String?
    
    
    static let placeholder = Currency(id: 0, code: "EGP", name: "Egyptian Pound")
}

struct CurrentDeal: Codable {
    let capacity: Double?
    let type: String?
    let currency: Currency?
}
