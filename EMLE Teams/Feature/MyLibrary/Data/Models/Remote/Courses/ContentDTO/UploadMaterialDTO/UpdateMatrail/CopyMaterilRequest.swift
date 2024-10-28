//
//  CopyMaterilRequest.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 23/10/2024.
//

import Foundation
import EMLECore
import Alamofire

class CopyMaterilRequest: CustomRequest {
    var endPoint: APIEndPoint { .copyMatrail }
    var method: RequestMethod { .post }
    var url: String { String(format: MainCloudConfig.apiUrl + endPoint.value, matrialId) }
    
    var dto: RequestDTO? { _dto }

    private let _dto: CopyMaterailDTO
    
    var matrialId: Int

    init(copyMaterial: CopyMaterial) {
        self.matrialId = copyMaterial.materilId
        let copyMaterialDTO = CopyMaterailDTO(course_folder_id: copyMaterial.courseFolderId, persist: copyMaterial.persist)
        
        self._dto = copyMaterialDTO
    }
}

