//
//  ContentCourseRequestDTO.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 17/08/2024.
//

import Foundation
import EMLECore

class ContentCourseRequestDTO: CustomRequest {
    
    var endPoint: APIEndPoint { .getContent }
    
    var url: String { String(format: MainCloudConfig.apiUrl + endPoint.value, courseId) }
    
    let courseId: Int
    
    init(courseId: Int) {
        self.courseId = courseId
    }
}
