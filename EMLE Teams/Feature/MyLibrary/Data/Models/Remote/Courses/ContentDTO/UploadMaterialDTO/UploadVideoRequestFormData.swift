//
//  UploadMaterialRequestFormData.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 05/10/2024.
//

import Foundation
import EMLECore

class UploadVideoRequestFormData: Codable {
    let name: String?
    let is_visible: Bool?
    let should_pass: Bool?
    let is_free: Bool?
    let course_folder_id: Int?
    let file: Data?
    let video: VideoRequestFormData?

    // Initializer
    init(name: String,
         is_visible: Bool = true,
         should_pass: Bool = false,
         is_free: Bool = false,
         course_folder_id: Int,
         file: Data? = nil,
         video: VideoRequestFormData) {
        
        self.name = name
        self.is_visible = is_visible
        self.should_pass = should_pass
        self.is_free = is_free
        self.course_folder_id = course_folder_id
        self.file = file
        self.video = video
    }

    // Form data generation
    var formData: FormData {
        var data: FormData = [:]
        
        data["name"] = name
        data["is_visible"] = is_visible == true ? 1 : 0
        data["should_pass"] = should_pass == true ? 1 : 0
        data["is_free"] = is_free == true ? 1 : 0
        data["course_folder_id"] = course_folder_id
        
        if let file = file {
            data["file"] = file
        }
        
        if let video = video {
            data.merge(video.formData) { (_, new) in new }
        }

        return data
    }
}
