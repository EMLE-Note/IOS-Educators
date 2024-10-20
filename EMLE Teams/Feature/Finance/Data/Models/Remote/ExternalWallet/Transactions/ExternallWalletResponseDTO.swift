//
//  ExternallWalletResponseDTO.swift
//  EMLE Teams
//
//  Created by iOSAYed on 20/07/2024.
//

import Foundation
class ExternallWalletResponseDTO : Codable {
    let id: Int
    let content_type: String
    let enrollment: EnrollmentDTO
    let receivable: SecretaryDTO
    let amount: Double
    let created_at: String
}
