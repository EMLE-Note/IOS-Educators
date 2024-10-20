//
//  Currency.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 02/09/2024.
//

import Foundation

// MARK: - Currency
struct CurrencyBank: Codable {
    let id: Int
    let name, code: String
}

extension CurrencyBank {
    
    static let placeholder: CurrencyBank = {
        CurrencyBank(id: 0, name: "", code: "")
    }()
}
