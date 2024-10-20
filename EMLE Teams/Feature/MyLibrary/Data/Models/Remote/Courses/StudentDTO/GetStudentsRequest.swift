//
//  GetStudentsRequest.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 19/08/2024.
//

import Foundation
import EMLECore

class GetStudentsRequest: CustomRequest {
    var endPoint: APIEndPoint { .getStudents }
    var url: String { String(format: MainCloudConfig.apiUrl + endPoint.value, courseId) }
    
    var parameters: Parameters? {
        let parameters = filters.parameters
        return parameters.isEmpty ? nil : parameters
    }
    
    let filters: GetStudentsFilterRequestDTO
    var courseId: Int
    
    init(courseId: Int, filters: GetStudentsFilterRequestDTO) {
        self.filters = filters
        self.courseId = courseId
    }
    
    func encode(to encoder: any Encoder) throws { }
}
