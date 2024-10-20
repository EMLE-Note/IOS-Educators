//
//  CurrentDeal.swift
//  EMLE Teams
//
//  Created by iOSAYed on 03/07/2024.
//

import Foundation

extension CurrentDealDTO {
    
    func toDomain() -> CurrentDeal {
        return CurrentDeal(
            capacity: capacity,
            type: type,
            currency: currency?.toDomain()
        )
    }
}
