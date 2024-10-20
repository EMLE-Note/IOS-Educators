//
//  UpdateCourseRequest.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 21/08/2024.
//

import Foundation
import EMLECore
import Alamofire

class EditCourseSettingRequest: CustomRequest {

    var endPoint: APIEndPoint { .updateCourse }
    var method: RequestMethod { .post }
    var url: String { String(format: MainCloudConfig.apiUrl + endPoint.value, courseId) }
    
    var formData: FormData? {
        let parameters = data.formData
        
        return parameters.isEmpty ? nil : parameters
    }
    
    let data: UpdateCourseFormDataRequestDTO

    var courseId: Int
    
    init(courseId: Int, data: UpdateCourseFormDataRequestDTO) {
        self.courseId = courseId
        self.data = data
    }
}
