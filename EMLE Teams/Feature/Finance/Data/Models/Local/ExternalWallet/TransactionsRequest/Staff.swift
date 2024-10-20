//
//  Staff.swift
//  EMLE Teams
//
//  Created by iOSAYed on 06/08/2024.
//

import Foundation
import EMLECore

struct Staff: Codable {
    let id: Int
    let name, mobile: String
    let image: ImageUrl?
    let type: String
}

extension Staff {
    static let placeholder = Staff(id: 0, name: "Elsayed", mobile: "+201116064003", image: nil, type: "staff")
}
