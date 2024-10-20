//
//  GetCoursesFilterRequestDTO.swift
//  EMLE Teams
//
//  Created by iOSAYed on 16/08/2024.
//

import EMLECore
import Foundation

struct GetCoursesFilterRequestDTO: Codable {
    var parameters: Parameters {
        var params: Parameters = [:]
        
        if !fieldId.isEmpty {
            params[CodingKeys.fieldId.stringValue] = getFilterString(filterValues: fieldId)
        }
        
        if !fieldName.isEmpty {
            params[CodingKeys.fieldName.stringValue] = getFilterString(filterValues: fieldName)
        }
        
        if !teamId.isEmpty {
            params[CodingKeys.teamId.stringValue] = getFilterString(filterValues: teamId)
        }
        
        if !teamName.isEmpty {
            params[CodingKeys.teamName.stringValue] = getFilterString(filterValues: teamName)
        }
        
        if !sort.isEmpty {
            params[CodingKeys.sort.stringValue] = getFilterString(filterValues: sort)
        }
        if !uuid.isEmpty {
            params[CodingKeys.uuid.stringValue] = getFilterString(filterValues: uuid)
        }
        if !institutionName.isEmpty {
            params[CodingKeys.institutionName.stringValue] = getFilterString(filterValues: institutionName)
        }
        if !institutionId.isEmpty {
            params[CodingKeys.institutionId.stringValue] = getFilterString(filterValues: institutionId)
        }
        
        return params
    }
    
    enum CodingKeys: String, CodingKey {
        case fieldId = "filter[field.id]"
        case fieldName = "filter[field.name]"
        case teamId = "filter[team_id]"
        case teamName = "filter[team.name]"
        case uuid = "filter[uuid]"
        case institutionName = "filter[institution.name]"
        case institutionId = "filter[institution.id]"
        case search = "filter[search]"
        case sort
    }

    let fieldId: [String]
    let fieldName: [String]
    let teamId: [String]
    let teamName: [String]
    let uuid: [String]
    let institutionName: [String]
    let institutionId: [String]
    let search: [String]
    let sort: [String]
    
    private func getFilterString(filterValues: [String]) -> String {
        filterValues.params
    }
}
