//
//  EditCourseSecurityDTO.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 26/08/2024.
//

import Foundation
import EMLECore

class EditCourseSecurityDTO: Codable, RequestDTO {
    var security: EditSecurityDTO?
    var _method: String? = "put"
    
    init(security: EditSecurityDTO?, _method: String? = "put") {
        self.security = security
        self._method = _method
    }
}
