//
//  UpdateCourse.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 21/08/2024.
//

import Foundation

struct UpdateCourse {
    let name: String?
    let status: Int?
    var image: Data?
    let price: Double?
    let duration: Int?
    let publishAt: String?
    let isVisible: Int?
    let isAllowedOffline: Int?
    let fieldID: Int?
    let institutionID: Int?
    let overview: String?
    let expireAt: String?
    let security: Security?
    let targets: [Target]?
    let groups: [Int]?

    init(name: String? = nil, status: Int? = nil, price: Double? = nil, duration: Int? = nil,
         publishAt: String? = nil, isVisible: Int? = nil, isAllowedOffline: Int? = nil,
         fieldID: Int? = nil, institutionID: Int? = nil, overview: String? = nil,
         expireAt: String? = nil, security: Security? = nil, targets: [Target]? = nil,
         groups: [Int]? = nil) {
        self.name = name
        self.status = status
        self.price = price
        self.duration = duration
        self.publishAt = publishAt
        self.isVisible = isVisible
        self.isAllowedOffline = isAllowedOffline
        self.fieldID = fieldID
        self.institutionID = institutionID
        self.overview = overview
        self.expireAt = expireAt
        self.security = security
        self.targets = targets
        self.groups = groups
    }
}
