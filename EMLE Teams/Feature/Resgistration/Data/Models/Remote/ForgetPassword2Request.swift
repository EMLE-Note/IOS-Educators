//
//  ForgetPassword2Request.swift
//  EMLE Learners
//
//  Created by Abdelrhman Sultan on 28/04/2024.
//

import EMLECore

class ForgetPassword2Request: CustomRequest {
    var endPoint: APIEndPoint { .forgetPassword2 }
    var method: RequestMethod { .post }
    
    var dto: RequestDTO? { _dto }
    
    let _dto: ForgetPassword2RequestDTO
    
    init(mobile_code: String, mobile: String, otp_code: String) {
        
        _dto = ForgetPassword2RequestDTO(mobile_code: mobile_code,
                                         mobile: mobile,
                                         otp_code: otp_code)
    }
}
