//
//  MonitorBillItemMapper.swift
//  EMLE Teams
//
//  Created by iOSAYed on 03/07/2024.
//

import Foundation

extension MonitorBillItemDTO {
    
    func toDomain() -> MonitorBillItem {
        return MonitorBillItem(price: price, value: value)
    }
}
