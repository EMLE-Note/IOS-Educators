//
//  EditCourseTargetDTO.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 15/09/2024.
//

import Foundation
import EMLECore

class EditCourseTargetDTO: Codable, RequestDTO {
    var targets: [EditTargetDTO]?
    var display_price: Int?
    var display_students_count: Int?
    var _method: String? = "put"
    
    init(targets: [EditTargetDTO]?, _method: String? = "put", display_price: Int?, display_students_count: Int?) {
        self.targets = targets
        self._method = _method
        self.display_price = display_price
        self.display_students_count = display_students_count
    }
}
