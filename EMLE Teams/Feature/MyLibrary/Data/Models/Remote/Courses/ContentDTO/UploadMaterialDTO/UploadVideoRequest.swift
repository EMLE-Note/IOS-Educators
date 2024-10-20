//
//  UploadMaterialRequest.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 05/10/2024.
//

import Foundation
import EMLECore
import Alamofire

class UploadVideoRequest: CustomRequest {
    var endPoint: APIEndPoint { .uploadVideo }
    var method: RequestMethod { .post }
    var url: String { String(format: MainCloudConfig.apiUrl + endPoint.value) }
    
    var dto: RequestDTO? { _dto }

    private let _dto: UploadVideoDTO

    init(data: UploadVideo) {

        self._dto = UploadVideoDTO(
            name: data.name,
            is_visible: data.isVisible,
            should_pass: data.shouldPass,
            is_free: data.isFree,
            course_folder_id: data.courseFolderId,
            file: data.file,
            video: VideoDTO(
                duration: data.video.duration,
                size: data.video.size,
                server_id: data.video.serverId,
                upload_type: data.video.uploadType,
                link: data.video.link
            )
        )
    }
}
