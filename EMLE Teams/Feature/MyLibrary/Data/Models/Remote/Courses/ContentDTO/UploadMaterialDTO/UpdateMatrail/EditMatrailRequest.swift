//
//  EditMatrailRequest.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 23/10/2024.
//

import Foundation
import EMLECore
import Alamofire

class EditMatrailRequest: CustomRequest {
    var endPoint: APIEndPoint { .editMatrail }
    var method: RequestMethod { .post }
    var url: String { String(format: MainCloudConfig.apiUrl + endPoint.value, matrialId) }
    
    var dto: RequestDTO? { _dto }

    private let _dto: EditMatrailDTO
    
    var matrialId: Int

    init(editMatrail: EditMatrail) {
        self.matrialId = editMatrail.materilId
        let editMatrailDTO = EditMatrailDTO(name: editMatrail.name, is_visible: editMatrail.isVisible, should_pass: editMatrail.shouldPass, is_free: editMatrail.isFree)
        
        self._dto = editMatrailDTO
    }
}

