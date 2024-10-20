//
//  OwnerDTO.swift
//  EMLE Teams
//
//  Created by iOSAYed on 22/08/2024.
//

import Foundation
import EMLECore

class OwnerDTO: Codable {
    let id: Int
    let name: String
    let image: String?
    let overview: String?
    let job_title: String
    let field: FieldResponseDTO
}
