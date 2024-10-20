//
//  UpdateFolderRequest.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 20/08/2024.
//

import Foundation
import EMLECore
import Alamofire

class UpdateFolderRequest: CustomRequest {

    var endPoint: APIEndPoint { .updateFolder }
    var method: RequestMethod { .post }
    var url: String { String(format: MainCloudConfig.apiUrl + endPoint.value, folderId) }
    
    var dto: RequestDTO? { _dto }

    let _dto: UpdateFolderDTO
    
    var folderId: Int

    init(folderId: Int,
         isVisible: Int? = nil,
         name: String? = nil) {

        self.folderId = folderId
        _dto = UpdateFolderDTO(name: name, is_visible: isVisible)
    }
}
