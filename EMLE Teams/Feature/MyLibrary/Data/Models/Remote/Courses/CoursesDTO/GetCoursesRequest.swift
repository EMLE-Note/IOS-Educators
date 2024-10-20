//
//  GetCoursesRequest.swift
//  EMLE Teams
//
//  Created by iOSAYed on 16/08/2024.
//

import Foundation
import EMLECore

class GetCoursesRequest: CustomRequest {
    var endPoint: APIEndPoint { .getCourses }
    
    var parameters: Parameters? {
        let parameters = filters.parameters
        
        return parameters.isEmpty ? nil : parameters
    }
    
    let filters: GetCoursesFilterRequestDTO
    
    init(filters: GetCoursesFilterRequestDTO) {
        self.filters = filters
    }
    
    func encode(to encoder: any Encoder) throws { }
}
