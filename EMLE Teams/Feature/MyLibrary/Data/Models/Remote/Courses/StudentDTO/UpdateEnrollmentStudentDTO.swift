//
//  UpdateEnrollmentStudentDTO.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 19/08/2024.
//

import Foundation
import EMLECore
import Alamofire

class UpdateEnrollmentStudentDTO: RequestDTO, Codable {
    var status: Int? = nil
    var security: EditSecurityDTO?
    var method: String = "put"
    var locationId: Int? = nil
    var expireAt: String? = nil

    
    init(status: Int? = nil, security: EditSecurityDTO? = nil, method: String = "put", locationId: Int? = nil, expireAt: String? = nil) {
        self.status = status
        self.security = security
        self.method = method
        self.locationId = locationId
        self.expireAt = expireAt
    }
}
