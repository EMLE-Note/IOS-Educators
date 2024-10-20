//
//  UpdateCourseFormDataRequest.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 25/08/2024.
//

import Foundation

struct UpdateCourseFormDataRequest {
    var status: Int? = nil
    var name: String? = nil
    var image: Data? = nil
    var overview: String? = nil
    var duration: String? = nil
    var expireAt: String? = nil
    var publishAt: String? = nil
    var isVisible: Int? = nil
    var isAllowedOffline: Int? = nil
    var price: Double? = nil
    var method: String? = "put"
    var groups: [Int]? = nil
}

extension UpdateCourseFormDataRequest {
    static let empty = UpdateCourseFormDataRequest(
        status: 0,
        name: "",
        image: nil,
        overview: "",
        duration: "",
        expireAt: "",
        publishAt: "",
        isVisible: 0,
        isAllowedOffline: 0,
        price: 0.0,
        method: "put",
        groups: []
    )
}

