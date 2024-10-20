//
//  UpdateCourseFormDataRequestDTO.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 25/08/2024.
//

import Foundation
import EMLECore

class UpdateCourseFormDataRequestDTO: Codable {

    var status: Int? = nil
    var name: String? = nil
    var image: Data? = nil
    var overview: String? = nil
    var duration: String? = nil
    var expire_at: String? = nil
    var publish_at: String? = nil
    var is_visible: Int? = nil
    var is_allowed_offline: Int? = nil
    var price: Double? = nil
    var _method: String? = "put"
    var groups: [Int]? = nil

    // Form data generation
    var formData: FormData {
        var data: FormData = [:]

        if let name = name {
            data["name"] = name
        }
        if let status = status {
            data["status"] = status
        }
        if let overview = overview {
            data["overview"] = overview
        }
        if let duration = duration {
            data["duration"] = duration
        }
        if let publish_at = publish_at {
            data["publish_at"] = publish_at
        }
        if let expire_at = expire_at {
            data["expire_at"] = expire_at
        }
        if let is_visible = is_visible {
            data["is_visible"] = is_visible
        }
        if let is_allowed_offline = is_allowed_offline {
            data["is_allowed_offline"] = is_allowed_offline
        }
        if let price {
            data["price"] = price
        }
        if let image = image {
            data["image"] = image
        }
        if let _method = _method {
            data["_method"] = _method
        }
        if let groups {
            data["groups"] = groups
        }
        return data
    }
    
    init(
        status: Int? = nil,
        name: String? = nil,
        image: Data? = nil,
        overview: String? = nil,
        duration: String? = nil,
        expire_at: String? = nil,
        publish_at: String? = nil,
        is_visible: Int? = nil,
        is_allowed_offline: Int? = nil,
        price: Double? = nil,
        _method: String? = nil,
        groups: [Int]? = nil
    ) {
        
        self.status = status
        self.name = name
        self.image = image
        self.overview = overview
        self.duration = duration
        self.expire_at = expire_at
        self.publish_at = publish_at
        self.is_visible = is_visible
        self.is_allowed_offline = is_allowed_offline
        self.price = price
        self._method = _method
        self.groups = groups
    }
}
