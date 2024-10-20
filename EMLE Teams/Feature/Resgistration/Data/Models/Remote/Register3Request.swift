//
//  Register3Request.swift
//  EMLE Learners
//
//  Created by Abdelrhman Sultan on 20/04/2024.
//

import EMLECore

class Register3Request: CustomRequest {
    var endPoint: APIEndPoint { .register3 }
    var method: RequestMethod { .post }
    
    var dto: RequestDTO? { _dto }
    
    let _dto: Register3RequestDTO
    
    init(mobile_code: String, mobile: String, otp_code: String, password: String, password_confirmation: String) {
        
        _dto = Register3RequestDTO(mobile_code: mobile_code,
                                   mobile: mobile,
                                   otp_code: otp_code,
                                   password: password,
                                   password_confirmation: password_confirmation)
    }
}
