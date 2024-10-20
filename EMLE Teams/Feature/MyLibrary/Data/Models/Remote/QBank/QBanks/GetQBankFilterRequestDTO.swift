//
//  GetQBankFilterRequestDTO.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 02/09/2024.
//

import EMLECore
import Foundation

struct GetQBankFilterRequestDTO: Codable {
    var parameters: Parameters {
        var params: Parameters = [:]
        
        if !fieldId.isEmpty {
            params[CodingKeys.fieldId.stringValue] = getFilterString(filterValues: fieldId)
        }
        if !title.isEmpty {
            params[CodingKeys.title.stringValue] = getFilterString(filterValues: title)
        }
        if !sort.isEmpty {
            params[CodingKeys.sort.stringValue] = getFilterString(filterValues: sort)
        }
        if !uuid.isEmpty {
            params[CodingKeys.uuid.stringValue] = getFilterString(filterValues: uuid)
        }
        
        return params
    }
    
    enum CodingKeys: String, CodingKey {
        case fieldId = "filter[field.id]"
        case uuid = "filter[uuid]"
        case title = "filter[title]"
        case sort
    }

    let fieldId: [String]
    let title: [String]
    let uuid: [String]
    let sort: [String]
    
    private func getFilterString(filterValues: [String]) -> String {
        filterValues.params
    }
}

