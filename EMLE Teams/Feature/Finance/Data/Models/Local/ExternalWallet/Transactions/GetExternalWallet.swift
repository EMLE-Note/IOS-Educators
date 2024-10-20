//
//  GetExternalWallet.swift
//  EMLE Teams
//
//  Created by iOSAYed on 20/07/2024.
//

import Foundation

struct GetExternalWallet {
    let filters: TransactionsContentFilter
}

extension GetExternalWallet {
    static let empty = GetExternalWallet(filters: .empty)
}

