//
//  GetExternalWalletParameters.swift
//  EMLE Teams
//
//  Created by iOSAYed on 20/07/2024.
//

import Foundation

struct TransactionsContentFilter:Codable {
    var enrollmentType: [String]
    var contentType: [String]
    var amount: [String]
    var search: [String]
    var teamStaffId: [String]
    var sort: [String]
}

extension TransactionsContentFilter {
    static let empty = TransactionsContentFilter(enrollmentType: [], contentType: [], amount: [], search: [],teamStaffId: [],sort: [])
}
