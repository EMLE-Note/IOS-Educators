//
//  CurrancyMapper.swift
//  EMLE Teams
//
//  Created by iOSAYed on 03/07/2024.
//

import Foundation

extension CurrencyDTO {
    func toDomain() -> Currency {
        return Currency(id: id, code: code, name: name)
    }
}
