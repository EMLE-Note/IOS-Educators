//
//  GetEnrollmentRequestDTO.swift
//  EMLE Teams
//
//  Created by iOSAYed on 11/08/2024.
//


import Foundation
import EMLECore

struct GetEnrollmentRequestDTO: Codable {
    
    var parameters: Parameters {
        var params: Parameters = [:]
        
      
        
        if !enrollmentType.isEmpty {
            
            params[CodingKeys.enrollmentType.stringValue] = getFilterString(filterValues: enrollmentType)
        }
        
        if !remained.isEmpty {
            
            params[CodingKeys.remained.stringValue] = getFilterString(filterValues: remained)
        }
        
        if !search.isEmpty {
            
            params[CodingKeys.search.stringValue] = getFilterString(filterValues: search)
        }
        
        if !sort.isEmpty {
            
            params[CodingKeys.sort.stringValue] = getFilterString(filterValues: sort)
        }
        
        return params
    }
    
    enum CodingKeys: String, CodingKey {
        case enrollmentType = "filter[type]"
        case remained = "filter[remained]"
        case sort   = "sort"
        case search = "filter[search]"
    }
    
    let enrollmentType: [String]
    let remained: [String]
    let search: [String]
    let sort: [String]
    
    private func getFilterString(filterValues: [String]) -> String {
        filterValues.params
    }
}
