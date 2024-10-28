//
//  InvitationActionParametersDTO.swift
//  EMLE Teams
//
//  Created by iOSAYed on 27/10/2024.
//

import Foundation
import EMLECore


struct InvitationActionParametersDTO: Codable {
    var parameters: Parameters {
        var params: Parameters = [:]
        
        if !action.isEmpty {
            params[CodingKeys.action.stringValue] = getFilterString(filterValues: action)
        }
        
        return params
    }
    
    enum CodingKeys: String, CodingKey {
        case action = "action"
    }

    let action: [String]
    
    private func getFilterString(filterValues: [String]) -> String {
        filterValues.params
    }
}
