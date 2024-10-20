//
//  ActivationAllDTO.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 14/10/2024.
//

import Foundation
import EMLECore

class ActivationAllDTO: Codable, RequestDTO {
    var id: [Int]?
    
    init(id: [Int]?) {
        self.id = id
    }
}
