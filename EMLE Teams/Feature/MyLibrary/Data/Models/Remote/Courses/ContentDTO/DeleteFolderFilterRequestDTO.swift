//
//  DeleteFolderFilterRequestDTO.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 20/08/2024.
//

import Foundation
import EMLECore
import Alamofire

struct DeleteFolderFilterRequestDTO: Codable {
    var parameters: Parameters {
        var params: Parameters = [:]
        
        if !fieldId.isEmpty {
            params[CodingKeys.fieldId.stringValue] = getFilterString(filterValues: fieldId)
        }

        if !uuid.isEmpty {
            params[CodingKeys.uuid.stringValue] = getFilterString(filterValues: uuid)
        }
        
        return params
    }
    
    enum CodingKeys: String, CodingKey {
        case fieldId = "filter[id]"
        case uuid = "filter[uuid]"
    }

    let fieldId: [String]
    let uuid: [String]
    
    private func getFilterString(filterValues: [String]) -> String {
        filterValues.params
    }
}

