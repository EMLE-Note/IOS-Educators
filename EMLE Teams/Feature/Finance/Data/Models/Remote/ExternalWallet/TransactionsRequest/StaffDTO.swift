//
//  StaffDTO.swift
//  EMLE Teams
//
//  Created by iOSAYed on 06/08/2024.
//

import Foundation
import EMLECore

class StaffDTO: Codable {
    let id: Int
    let name, mobile: String
    let image: String?
    let type: String
}
