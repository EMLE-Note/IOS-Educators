//
//  CopyMaterailDTO.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 23/10/2024.
//

import Foundation
import EMLECore

class CopyMaterailDTO: Codable, RequestDTO {
    var course_folder_id: Int?
    var persist: Int?
    
    init(course_folder_id: Int?, persist: Int?) {
        self.course_folder_id = course_folder_id
        self.persist = persist
    }
}
