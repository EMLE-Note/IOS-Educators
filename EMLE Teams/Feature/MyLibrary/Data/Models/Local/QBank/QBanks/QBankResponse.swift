//
//  QBankResponse.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 02/09/2024.
//

import Foundation
import EMLECore

struct QBankResponse {
    let qbanks: [QBank]
    let pagination: PaginatedContent<[QBank]>
}
