//
//  ForgetPassword1Request.swift
//  EMLE Learners
//
//  Created by Abdelrhman Sultan on 28/04/2024.
//

import EMLECore

class ForgetPassword1Request: CustomRequest {
    var endPoint: APIEndPoint { .forgetPassword1 }
    var method: RequestMethod { .post }
    
    var dto: RequestDTO? { _dto }
    
    let _dto: ForgetPassword1RequestDTO
    
    init(mobile_code: String, mobile: String, verification_method: String) {
        
        _dto = ForgetPassword1RequestDTO(mobile_code: mobile_code,
                                         mobile: mobile,
                                         verification_method: verification_method)
    }
}
