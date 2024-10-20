//
//  GetExternallWalletResponseDTO.swift
//  EMLE Teams
//
//  Created by iOSAYed on 20/07/2024.
//

import Foundation
import EMLECore

class GetExternallWalletResponseDTO: Codable {
    
    let data: [ExternallWalletResponseDTO]
    let pagination: PaginationResponseDTO
    let external_wallet_sum: Double
    let transaction_request_count: Int
}
