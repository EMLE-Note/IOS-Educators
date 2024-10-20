//
//  GetEnrollmentRequest.swift
//  EMLE Teams
//
//  Created by iOSAYed on 11/08/2024.
//

import Foundation
import EMLECore

class GetEnrollmentRequest: CustomRequest {
    var endPoint: APIEndPoint { .getEnrollmentsCourses }
    
    var parameters: Parameters? {
        let parameters = filters.parameters
        
        return parameters.isEmpty ? nil : parameters
    }
    
    let filters: GetEnrollmentRequestDTO
    
    init(filters: GetEnrollmentRequestDTO) {
        self.filters = filters
    }
    
    func encode(to encoder: any Encoder) throws { }
}
