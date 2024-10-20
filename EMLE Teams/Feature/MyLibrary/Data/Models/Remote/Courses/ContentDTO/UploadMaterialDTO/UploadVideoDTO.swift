//
//  UploadVideoDTO.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 06/10/2024.
//

import Foundation
import EMLECore

class UploadVideoDTO: Codable, RequestDTO {
    let name: String?
    let is_visible: Bool?
    let should_pass: Bool?
    let is_free: Bool?
    let course_folder_id: Int?
    let file: Data?
    let video: VideoDTO?

    // New initializer with basic types
    init(name: String?,
         is_visible: Bool?,
         should_pass: Bool?,
         is_free: Bool?,
         course_folder_id: Int?,
         file: Data?,
         video: VideoDTO?) {
        self.name = name
        self.is_visible = is_visible
        self.should_pass = should_pass
        self.is_free = is_free
        self.course_folder_id = course_folder_id
        self.file = file
        self.video = video
    }
}
