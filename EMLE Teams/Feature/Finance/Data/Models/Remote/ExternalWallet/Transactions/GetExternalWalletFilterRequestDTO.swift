//
//  GetExternalWalletFilterRequestDTO.swift
//  EMLE Teams
//
//  Created by iOSAYed on 20/07/2024.
//

import Foundation
import EMLECore

struct GetExternalWalletFilterRequestDTO: Codable {
    
    var parameters: Parameters {
        var params: Parameters = [:]
        
      
        
        if !enrollmentType.isEmpty {
            
            params[CodingKeys.enrollmentType.stringValue] = getFilterString(filterValues: enrollmentType)
        }
        
        if !contentType.isEmpty {
            
            params[CodingKeys.contentType.stringValue] = getFilterString(filterValues: contentType)
        }
        
        if !amount.isEmpty {
            
            params[CodingKeys.amount.stringValue] = getFilterString(filterValues: amount)
        }
        
        if !search.isEmpty {
            
            params[CodingKeys.search.stringValue] = getFilterString(filterValues: search)
        }
        
        if !sort.isEmpty {
            
            params[CodingKeys.sort.stringValue] = getFilterString(filterValues: sort)
        } 
        if !teamStaffId.isEmpty {
            
            params[CodingKeys.teamStaffId.stringValue] = getFilterString(filterValues: teamStaffId)
        }
        
        return params
    }
    
    enum CodingKeys: String, CodingKey {
        case enrollmentType = "filter[enrollment_type]"
        case contentType = "filter[content_type]"
        case amount = "filter[amount]"
        case teamStaffId = "filter[team_staff_id]"
        case sort   = "sort"
        case search = "filter[search]"
    }
    
    let enrollmentType: [String]
    let contentType: [String]
    let amount: [String]
    let search: [String]
    let teamStaffId: [String]
    let sort: [String]
    
    private func getFilterString(filterValues: [String]) -> String {
        filterValues.params
    }
}
