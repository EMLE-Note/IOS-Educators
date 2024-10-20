//
//  GetQBankSettingFilterRequest.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 25/09/2024.
//

import Foundation

struct GetQBankSettingFilterRequest: Codable {
    var fieldTitle: [String]
}

extension GetQBankSettingFilterRequest {
    static let empty = GetQBankSettingFilterRequest(fieldTitle: [])
}
