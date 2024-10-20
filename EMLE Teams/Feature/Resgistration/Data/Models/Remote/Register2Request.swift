//
//  Register2Request.swift
//  EMLE Learners
//
//  Created by Abdelrhman Sultan on 16/04/2024.
//

import EMLECore

class Register2Request: CustomRequest {
    var endPoint: APIEndPoint { .register2 }
    var method: RequestMethod { .post }
    
    var dto: RequestDTO? { _dto }
    
    let _dto: Register2RequestDTO
    
    init(mobile_code: String, mobile: String, otp_code: String) {
        
        _dto = Register2RequestDTO(mobile_code: mobile_code,
                                   mobile: mobile,
                                   otp_code: otp_code)
    }
}
