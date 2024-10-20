//
//  GetQBankResponseDTO.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 02/09/2024.
//

import Foundation
import EMLECore

class GetQBankResponseDTO: Codable {
    let qbanks: [QBankDTO]
    let pagination: PaginationResponseDTO
}
