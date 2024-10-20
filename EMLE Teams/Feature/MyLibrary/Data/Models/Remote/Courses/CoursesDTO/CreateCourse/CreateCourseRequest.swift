//
//  CreateCourseRequest.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 19/09/2024.
//

import Foundation
import EMLECore
import Alamofire

class CreateCourseRequest: CustomRequest {

    var endPoint: APIEndPoint { .createCourse }
    var method: RequestMethod { .post }
    var url: String { String(format: MainCloudConfig.apiUrl + endPoint.value) }
    
    var formData: FormData? {
        let parameters = data.formData
        
        return parameters.isEmpty ? nil : parameters
    }
    
    let data: CreateCourseRequestFormData
    
    init(data: CreateCourseRequestFormData) {
        self.data = data
    }
}
