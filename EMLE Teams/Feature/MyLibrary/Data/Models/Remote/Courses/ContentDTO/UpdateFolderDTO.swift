//
//  UpdateFolderDTO.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 20/08/2024.
//

import Foundation
import EMLECore

class UpdateFolderDTO: RequestDTO {
    var name: String? = nil
    var is_visible: Int? = nil
    var _method: String = "put"
    
    init(name: String? = nil, is_visible: Int? = nil, _method: String = "put") {
        self.is_visible = is_visible
        self.name = name
        self._method = _method
    }
}
