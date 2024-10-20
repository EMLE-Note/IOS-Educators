//
//  SearchStaffDTO.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 14/10/2024.
//

import Foundation
import EMLECore

class SearchStaffDTO: Codable, RequestDTO {
    var mobile_code: String?
    var mobile: String?
    
    init(mobile_code: String? = nil, mobile: String? = nil) {
        self.mobile_code = mobile_code
        self.mobile = mobile
    }
}
