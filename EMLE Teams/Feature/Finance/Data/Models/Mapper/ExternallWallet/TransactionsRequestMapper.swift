//
//  TransactionsRequestMapper.swift
//  EMLE Teams
//
//  Created by iOSAYed on 06/08/2024.
//

import Foundation
import EMLECore

extension [GetTransactionsRequestDTO] {
    func toDomain() throws -> [TransactionRequests] {
        try map { $0.toDomain()}
    }
}

extension GetTransactionsRequestDTO {
    func toDomain() -> TransactionRequests {
        var imageUrl: ImageUrl? = nil
        if let image{
            imageUrl = ImageUrl(urlString: image)
        }
       return TransactionRequests(transactionId: id, staff: staff.toDomain(), amount: amount, image: imageUrl, createdAt: created_at)
    }
}


extension StaffDTO {
    func toDomain() -> Staff {
        var imageUrl: ImageUrl? = nil
        if let image{
            imageUrl = ImageUrl(urlString: image)
        }
       return Staff(id: id, name: name, mobile: mobile, image: imageUrl, type: type)
    }
}
