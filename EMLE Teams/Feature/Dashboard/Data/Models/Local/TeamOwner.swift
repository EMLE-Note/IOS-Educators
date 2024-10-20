//
//  Owner.swift
//  EMLE Teams
//
//  Created by iOSAYed on 22/09/2024.
//

import Foundation

// MARK: - Owner
struct TeamOwner: Codable {
    let id: Int
    let type: String
    let typeID: Int
    let name, mobileCode, mobile: String
    let email: String?
    let image: String
    let countryID, cityID, appVersion, learningType: Int?
    let avaterID: Int?
    let status: Int
    let registerStatus: String
    let emailVerifiedAt: String?
    let createdAt, updatedAt, fullMobile: String
}
