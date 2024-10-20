//
//  EnrollmentContentDTO.swift
//  EMLE Teams
//
//  Created by iOSAYed on 20/07/2024.
//

import Foundation

class EnrollmentContentDTO: Codable {
    let id: Int
    let name: String
    let image: String?
    let price: Double
    let image_conversions: String?
}
