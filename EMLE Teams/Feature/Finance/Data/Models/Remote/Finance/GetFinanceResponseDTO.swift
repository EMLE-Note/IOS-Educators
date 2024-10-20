//
//  GetFinanceResponseDTO.swift
//  EMLE Teams
//
//  Created by iOSAYed on 02/07/2024.
//

import Foundation


class GetFinanceResponseDTO: Codable {
    let balance, debts, external_wallet: Double?
    let current_deal: CurrentDealDTO?
    let bills: BillsDTO?
}


class CurrentDealDTO: Codable {
    let capacity: Double?
    let type: String?
    let currency: CurrencyDTO?
}


class BillsDTO: Codable {
    let status: Int
    let total: Double?
    let current: BillDataDTO?
    let unpaid: [BillDataDTO]
}


class BillDataDTO: Codable {
    let id: Int?
    let uuid: String?
    let data: MonitorBillDTO?
    let price:Double?
    let status: Int?
    let currency: CurrencyDTO?
    let due_date, created_at: String?
}

class MonitorBillItemDTO: Codable {
    let price: Double?
    let value: Double?
}

class TokenItemDTO: Codable {
    let price: String?
    let value: Double?
}
extension TokenItemDTO {
    func toDomain() -> TokenItem {
        return TokenItem(price: price, value: value)
    }
}


class CurrencyDTO: Codable {
    let id: Int?
    let code, name: String?
}

enum MonitorBillPriceDTO: Codable {
    case int(Int)
    case string(String)
}


struct MonitorBillDTO: Codable {
    let students,bandwidth,storage: MonitorBillItemDTO?
    let tokens: TokenItemDTO?
}

extension MonitorBillDTO {
    func toDomain() -> MonitorBill {
        return MonitorBill(students: students?.toDomain(), bandwidth:bandwidth?.toDomain() ,storage: storage?.toDomain(),tokens: tokens?.toDomain())
    }
}
