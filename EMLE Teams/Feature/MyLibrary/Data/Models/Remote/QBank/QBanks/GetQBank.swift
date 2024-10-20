//
//  GetQBank.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 02/09/2024.
//

import Foundation
import EMLECore

struct GetQBank {
    let filters: GetQBankFilterRequest
}

extension GetQBank {
    static let empty = GetQBank(filters: .empty)
}
