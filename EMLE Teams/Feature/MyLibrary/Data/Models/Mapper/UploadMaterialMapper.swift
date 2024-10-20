//
//  UploadMaterialMapper.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 06/10/2024.
//

import Foundation

extension UploadVideo {
    func toRequest() -> UploadVideoRequest {
        return UploadVideoRequest(data: self)
    }
}


extension UploadVideo {
    func toRequestDTO() -> UploadVideoDTO {
        return UploadVideoDTO(name: name, is_visible: isVisible, should_pass: shouldPass, is_free: isFree, course_folder_id: courseFolderId, file: file, video: video.toRequest())
    }
}

extension Video {
    func toRequest() -> VideoDTO {
        return VideoDTO(duration: duration, size: size, server_id: serverId, upload_type: uploadType, link: link)
    }
}

extension UploadVideoResponseDTO {
    func toDomain() throws -> UploadVideoResponse {
        return try UploadVideoResponse(id: id, name: name, sort: sort, type: type, shouldPass: should_pass, isFree: is_free, isVisible: is_visible, materialable: materialable?.toDomain())
    }
}
