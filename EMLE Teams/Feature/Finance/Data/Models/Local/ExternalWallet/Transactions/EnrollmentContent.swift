//
//  EnrollmentContent.swift
//  EMLE Teams
//
//  Created by iOSAYed on 20/07/2024.
//

import EMLECore
import Foundation

struct EnrollmentContent: Codable {
    let id: Int
    let name: String
    let image: ImageUrl?
    let price: Double
    let imageConversions: ImageUrl?
}

extension EnrollmentContent {
    static let placeholder = EnrollmentContent(id: 0, name: "", image: nil, price: 0, imageConversions: nil)
}
