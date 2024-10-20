//
//  TransactionsRequestDTO.swift
//  EMLE Teams
//
//  Created by iOSAYed on 06/08/2024.
//

import Foundation

class GetTransactionsRequestDTO: Codable {
    let id: Int
    let staff: StaffDTO
    let amount: Double
    let image: String?
    let created_at: String
}
