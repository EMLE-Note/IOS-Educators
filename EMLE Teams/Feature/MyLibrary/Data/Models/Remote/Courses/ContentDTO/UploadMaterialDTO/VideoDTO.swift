//
//  VideoDTO.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 06/10/2024.
//

import Foundation
import EMLECore

class VideoDTO: Codable {
    let duration: Int?
    let size: Int?
    let server_id: Int?
    let upload_type: Int?
    let link: String?

    // New initializer with basic types
    init(duration: Int?,
         size: Int?,
         server_id: Int?,
         upload_type: Int?,
         link: String?) {
        self.duration = duration
        self.size = size
        self.server_id = server_id
        self.upload_type = upload_type
        self.link = link
    }
}
