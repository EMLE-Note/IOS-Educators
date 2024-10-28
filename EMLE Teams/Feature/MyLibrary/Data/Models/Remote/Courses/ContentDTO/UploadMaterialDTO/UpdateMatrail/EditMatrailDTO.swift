//
//  EditMatrailDTO.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 23/10/2024.
//

import Foundation
import EMLECore

class EditMatrailDTO: Codable, RequestDTO {
    var name: String?
    var is_visible: Int?
    var should_pass: Int?
    var is_free: Int?
    var _method: String? = "put"
    
    init(name: String? = nil, is_visible: Int? = nil, should_pass: Int? = nil, is_free: Int? = nil) {
        self.name = name
        self.is_visible = is_visible
        self.should_pass = should_pass
        self.is_free = is_free
    }
}
