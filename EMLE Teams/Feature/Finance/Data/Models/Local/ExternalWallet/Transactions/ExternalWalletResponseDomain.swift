//
//  ExternalWalletResponseDomain.swift
//  EMLE Teams
//
//  Created by iOSAYed on 21/07/2024.
//

import Foundation
import EMLECore

struct ExternalWalletResponseDomain {
    let externalWallets: [ExternalWallet]
    let pagination: PaginatedContent<[ExternalWallet]>
    let externalWalletSum: Double
    let transactionRequestCount: Int
}
