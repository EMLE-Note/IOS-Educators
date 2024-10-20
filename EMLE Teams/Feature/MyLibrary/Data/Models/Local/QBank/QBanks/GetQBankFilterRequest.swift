//
//  GetQBankFilterRequest.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 02/09/2024.
//

import Foundation

struct GetQBankFilterRequest {
    var fieldId: [String]
    var title: [String]
    var uuid: [String]
    var sort: [String]
}

extension GetQBankFilterRequest {
    static let empty = GetQBankFilterRequest(fieldId: [], title: [], uuid: [], sort: [])
}
