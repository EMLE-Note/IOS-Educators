//
//  GetQBankSettingFilterRequestDTO.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 25/09/2024.
//

import Foundation
import EMLECore

struct GetQBankSettingFilterRequestDTO: Codable {
    var parameters: Parameters {
        var params: Parameters = [:]
        
        if !fieldTitle.isEmpty {
            params[CodingKeys.fieldTitle.stringValue] = getFilterString(filterValues: fieldTitle)
        }
        
        return params
    }
    
    enum CodingKeys: String, CodingKey {
        case fieldTitle = "filter[title]"
    }

    let fieldTitle: [String]
    
    private func getFilterString(filterValues: [String]) -> String {
        filterValues.params
    }
}

