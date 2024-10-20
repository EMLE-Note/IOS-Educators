//
//  ForgetPassword3Request.swift
//  EMLE Learners
//
//  Created by Abdelrhman Sultan on 29/04/2024.
//

import EMLECore

class ForgetPassword3Request: CustomRequest {
    var endPoint: APIEndPoint { .forgetPassword3 }
    var method: RequestMethod { .post }
    
    var dto: RequestDTO? { _dto }
    
    let _dto: ForgetPassword3RequestDTO
    
    init(mobile_code: String, mobile: String, otp_code: String, new_password: String, new_password_confirmation: String) {
        
        _dto = ForgetPassword3RequestDTO(mobile_code: mobile_code,
                                         mobile: mobile,
                                         otp_code: otp_code,
                                         new_password: new_password,
                                         new_password_confirmation: new_password_confirmation)
    }
}
