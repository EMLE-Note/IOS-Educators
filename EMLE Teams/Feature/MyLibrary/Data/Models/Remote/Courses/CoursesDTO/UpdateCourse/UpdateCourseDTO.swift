//
//  UpdateCourseDTO.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 21/08/2024.
//

import Foundation
import EMLECore

class UpdateCourseDTO: RequestDTO, Codable {
    var status: Int? = nil
    var name: String? = nil
    var image: Data? = nil
    var overview: String? = nil
    var duration: Int? = nil
    var publishAt: String? = nil
    var expireAt: String? = nil
    var isVisible: Int? = nil
    var isAllowedOffline: Int? = nil
    var price: Double? = nil
    var method: String = "put"
    var groups: [Int]? = nil

    enum CodingKeys: String, CodingKey {
        case status
        case name
        case image
        case overview
        case duration
        case publishAt = "publish_at"
        case expireAt = "expire_at"
        case isVisible = "is_visible"
        case isAllowedOffline = "is_allowed_offline"
        case price
        case method = "_method"
        case groups
    }

    init(status: Int? = nil,
        name: String? = nil,
        image: Data? = nil,
        overview: String? = nil,
        duration: Int? = nil,
        publishAt: String? = nil,
        expireAt: String? = nil,
        isVisible: Int? = nil,
        isAllowedOffline: Int? = nil,
        price: Double? = nil,
        fingerPrintTime: Int? = nil,
        groups: [Int]? = nil,
        method: String = "put"
    ) {
        self.status = status
        self.name = name
        self.image = image
        self.overview = overview
        self.duration = duration
        self.publishAt = publishAt
        self.expireAt = expireAt
        self.isVisible = isVisible
        self.isAllowedOffline = isAllowedOffline
        self.price = price
        self.groups = groups
        self.method = method
    }
}
