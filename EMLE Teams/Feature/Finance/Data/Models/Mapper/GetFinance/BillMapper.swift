//
//  BillMapper.swift
//  EMLE Teams
//
//  Created by iOSAYed on 03/07/2024.
//

import Foundation

extension BillDataDTO {
    
    func toDomain() -> Bill {
        return Bill(id: id, uuid: uuid, data: data?.toDomain(), price: price, status: status, currency: currency?.toDomain(), dueDate: due_date, createdAt: created_at)
    }
}
