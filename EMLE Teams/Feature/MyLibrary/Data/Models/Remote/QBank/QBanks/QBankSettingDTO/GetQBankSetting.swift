//
//  GetQBankSetting.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 25/09/2024.
//

import Foundation
import EMLECore

struct GetQBankSetting {
    let filters: GetQBankSettingFilterRequest
}

extension GetQBankSetting {
    static let empty = GetQBankSetting(filters: .empty)
}
