//
//  DeclineCourseRequest.swift
//  EMLE Teams
//
//  Created by iOSAYed on 12/08/2024.
//

import Foundation
import EMLECore

class DeclineCourseRequest: CustomRequest {
    
    var method: RequestMethod { .post }
    var endPoint: APIEndPoint {.declineCourse}
    var url: String { String(format: MainCloudConfig.apiUrl + endPoint.value, enrollmentId) }
    
    var dto: RequestDTO? { _dto }
    
    let _dto: PostDeclineCourseRequestDTO
    
    let enrollmentId: Int
    
    init(enrollmentId: Int,paidAmount:String) {
        self.enrollmentId = enrollmentId
        _dto = PostDeclineCourseRequestDTO(paid_amount: paidAmount)
    }
}
