//
//  CreateCourseRequestFormData.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 19/09/2024.
//

import Foundation
import EMLECore

class CreateCourseRequestFormData: Codable {
    let uuid, name: String?
    let price: Double?
    let duration: String?
    var image: Data?
    let publish_at: String?
    let is_visible, is_allowed_offline: Int?
    let overview, expire_at: String?
    let security: SecurityRequestFromData?
    let targets: [TargetRequestFromData]?
    let groups: [Int]?

    // Initializer
    init(uuid: String? = nil,
         name: String? = nil,
         price: Double? = nil,
         duration: String? = nil,
         image: Data? = nil,
         publish_at: String? = nil,
         is_visible: Int? = nil,
         is_allowed_offline: Int? = nil,
         overview: String? = nil,
         expire_at: String? = nil,
         security: SecurityRequestFromData? = nil,
         targets: [TargetRequestFromData]? = nil,
         groups: [Int]? = nil) {
        
        self.uuid = uuid
        self.name = name
        self.price = price
        self.duration = duration
        self.image = image
        self.publish_at = publish_at
        self.is_visible = is_visible
        self.is_allowed_offline = is_allowed_offline
        self.overview = overview
        self.expire_at = expire_at
        self.security = security
        self.targets = targets
        self.groups = groups
    }

    // Form data generation
    var formData: FormData {
        var data: FormData = [:]

        if let uuid = uuid {
            data["uuid"] = uuid
        }
        if let name = name {
            data["name"] = name
        }
        if let price = price {
            data["price"] = price
        }
        if let duration = duration {
            data["duration"] = duration
        }
        if let image = image {
            data["image"] = image
        }
        if let publish_at = publish_at {
            data["publish_at"] = publish_at
        }
        if let is_visible = is_visible {
            data["is_visible"] = is_visible
        }
        if let is_allowed_offline = is_allowed_offline {
            data["is_allowed_offline"] = is_allowed_offline
        }
        if let overview = overview {
            data["overview"] = overview
        }
        if let expire_at = expire_at {
            data["expire_at"] = expire_at
        }
        if let security = security {
            data.merge(security.formData) { (_, new) in new }
        }
        if let targets = targets {
            for (index, target) in targets.enumerated() {
                let targetData = target.formData(index: index)
                for (key, value) in targetData {
                    data[key] = value
                }
            }
        }
        if let groups = groups {
            data["groups"] = groups
        }

        return data
    }
}
