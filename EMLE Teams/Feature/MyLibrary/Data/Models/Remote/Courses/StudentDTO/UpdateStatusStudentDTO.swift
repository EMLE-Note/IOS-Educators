//
//  UpdateStatusStudentDTO.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 20/08/2024.
//

import Foundation
import EMLECore

class UpdateStatusStudentDTO: RequestDTO {
    var status: Int? = nil
    var method: String = "put"
    
    enum CodingKeys: String, CodingKey {
        case status
        case method = "_method"
    }
    
    init(status: Int? = nil, method: String = "put") {
        self.status = status
    }
}
