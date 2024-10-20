//
//  GetEnrollmentResponseDTO.swift
//  EMLE Teams
//
//  Created by iOSAYed on 11/08/2024.
//

import Foundation
import EMLECore

class GetEnrollmentResponseDTO: Codable {
    let data: [EnrollmentResponseDTO]
    let pagination: PaginationResponseDTO
}
