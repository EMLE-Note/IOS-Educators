//
//  CreateGroupDTO.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 31/08/2024.
//

import Foundation
import EMLECore

class CreateGroupDTO: RequestDTO {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}
