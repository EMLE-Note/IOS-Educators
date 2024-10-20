//
//  DeleteCourseRequest.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 21/08/2024.
//

import Foundation
import EMLECore

class DeleteCourseRequest: CustomRequest {
    
    var endPoint: APIEndPoint { .deleteCourse }
    var method: RequestMethod { .delete }
    
    var url: String { String(format: MainCloudConfig.apiUrl + endPoint.value, courseId) }
    var parameters: Parameters? {
        let parameters = filters.parameters
        
        return parameters.isEmpty ? nil : parameters
    }
    
    let filters: DeleteCourseFilterRequestDTO
    var courseId: Int
    
    init(courseId: Int, filters: DeleteCourseFilterRequestDTO) {
        self.courseId = courseId
        self.filters = filters
    }
    
    func encode(to encoder: any Encoder) throws { }
}

