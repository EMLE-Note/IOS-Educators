//
//  CreateCourseRequestFrom.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 19/09/2024.
//

import Foundation

struct CreateCourseRequestFrom {
    var uuid: String
    var name: String
    var image: Data?
    var overview: String
    var duration: String?
    var expireAt: String?
    var publishAt: String?
    var isVisible: Int?
    var isAllowedOffline: Int
    var targets: [TargetRequestFrom]?
    var price: Double
    var method: String? = "put"
    var security: Security?
    var groups: [Int]? 
}

extension CreateCourseRequestFrom {
    static let empty = CreateCourseRequestFrom(
        uuid: "",
        name: "",
        image: nil,
        overview: "",
        duration: "",
        expireAt: "",
        publishAt: "",
        isVisible: 0,
        isAllowedOffline: 0,
        targets: [],
        price: 0.0,
        method: "put",
        security: nil,
        groups: []
    )
}
