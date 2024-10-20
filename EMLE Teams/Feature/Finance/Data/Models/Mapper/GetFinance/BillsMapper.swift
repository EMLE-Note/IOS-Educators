//
//  BillsMapper.swift
//  EMLE Teams
//
//  Created by iOSAYed on 03/07/2024.
//

import Foundation

extension BillsDTO {
    
    func toDomain() -> Bills {
        return Bills(
            status: status,
            total: total,
            current: current?.toDomain(),
            unpaid: unpaid.map { $0.toDomain() }
        )
    }
}
