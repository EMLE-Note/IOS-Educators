//
//  UpdateQBankFormDataRequestDTO.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 25/09/2024.
//

import Foundation
import EMLECore

class UpdateQBankFormDataRequestDTO: Codable {

    var title: String? = nil
    var image: Data? = nil
    var overview: String? = nil
    var price: Double? = nil
    var _method: String? = "put"

    // Form data generation
    var formData: FormData {
        var data: FormData = [:]

        if let title {
            data["title"] = title
        }
        if let price {
            data["price"] = price
        }
        if let overview = overview {
            data["overview"] = overview
        }
        if let image = image {
            data["image"] = image
        }
        if let _method = _method {
            data["_method"] = _method
        }
        return data
    }
    
    init(
        title: String? = nil,
        image: Data? = nil,
        overview: String? = nil,
        price: Double? = nil,
        _method: String? = nil
    ) {
        self.title = title
        self.image = image
        self.overview = overview
        self.price = price
        self._method = _method
    }
}
