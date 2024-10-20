//
//  UpdateQBankSettingFormDataRequest.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 25/09/2024.
//

import Foundation

struct UpdateQBankSettingFormDataRequest {
    var title: String?
    var image: Data?
    var overview: String?
    var price: Double?
    var method: String? = "put"
}

extension UpdateQBankSettingFormDataRequest {
    static let empty = UpdateQBankSettingFormDataRequest(
        title: "",
        image: nil,
        overview: "",
        price: 0.0,
        method: "put"
    )
}

