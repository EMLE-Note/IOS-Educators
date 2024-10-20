//
//  SearchStaffResponse.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 14/10/2024.
//

import Foundation
import EMLECore

struct SearchStaffResponse {
    let id: Int
    let type: String?
    let name: String
    let image: ImageUrl?
    let registerStatus: String?
    let registerStatusNumeric: Int?
}
