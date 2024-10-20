//
//  SignatureRequestFromData.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 19/09/2024.
//

import Foundation
import EMLECore
// MARK: - Signature
class SignatureRequestFromData: Codable {
    let font_size, font_weight: Int?

    // Initializer
    init(font_size: Int? = nil, font_weight: Int? = nil) {
        self.font_size = font_size
        self.font_weight = font_weight
    }

    // Form data generation
    var formData: FormData {
        var data: FormData = [:]

        if let font_size = font_size {
            data["security[signature][font_size]"] = font_size
        }
        if let font_weight = font_weight {
            data["security[signature][font_weight]"] = font_weight
        }

        return data
    }
}
