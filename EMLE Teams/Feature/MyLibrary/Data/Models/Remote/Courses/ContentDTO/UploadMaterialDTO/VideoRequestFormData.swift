//
//  VideoRequestFormData.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 05/10/2024.
//

import EMLECore
import Foundation

class VideoRequestFormData: Codable {
    let duration: Int?
    let size: Int?
    let server_id: Int?
    let upload_type: UploadType?
    let link: String?

    // Initializer
    init(duration: Int,
         size: Int,
         server_id: Int,
         upload_type: UploadType,
         link: String? = nil) {
        
        self.duration = duration
        self.size = size
        self.server_id = server_id
        self.upload_type = upload_type
        self.link = link
    }

    // Form data generation for video
    var formData: FormData {
        var data: FormData = [:]
        
        if let duration {
            data["duration"] = duration
        }
        if let size {
            data["size"] = size
        }
        if let server_id {
            data["server_id"] = server_id
        }
        if let upload_type {
            data["upload_type"] = upload_type.rawValue
        }
        
        if let link = link {
            data["link"] = link
        }

        return data
    }
}
