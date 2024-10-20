//
//  DataPassedToCheckout.swift
//  EMLE Teams
//
//  Created by iOSAYed on 09/07/2024.
//

import Foundation

struct DataPassedToCheckout {
    let billId:Int
    let currency:Currency
    let balance: Double
    let totalToPay:Double
}

extension DataPassedToCheckout {
    static let placeholder = DataPassedToCheckout(billId: 0, currency: .placeholder, balance: 0.0, totalToPay: 0.0)
}
