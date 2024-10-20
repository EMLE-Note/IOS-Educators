//
//  FinanceMapper.swift
//  EMLE Teams
//
//  Created by iOSAYed on 03/07/2024.
//

import Foundation

extension GetFinanceResponseDTO {
    
    func toDomain() -> Finance {
        return Finance(balance: balance, debts: debts, externalWallet: external_wallet, currentDeal: current_deal?.toDomain(), bills: bills?.toDomain())
    }
}

