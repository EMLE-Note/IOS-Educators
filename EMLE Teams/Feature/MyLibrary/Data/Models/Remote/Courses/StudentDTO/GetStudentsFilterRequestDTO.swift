//
//  GetStudentsFilterRequestDTO.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 19/08/2024.
//

import Foundation
import EMLECore

struct GetStudentsFilterRequestDTO: Codable {
    var parameters: Parameters {
        var params: Parameters = [:]
        
        if !fieldStatus.isEmpty {
            params[CodingKeys.fieldStatus.stringValue] = getFilterString(filterValues: fieldStatus)
        }
        
        return params
    }
    
    enum CodingKeys: String, CodingKey {
        case fieldStatus = "filter[status]"
    }
    
    let fieldStatus: [String]
    
    private func getFilterString(filterValues: [String]) -> String {
        filterValues.params
    }
}
