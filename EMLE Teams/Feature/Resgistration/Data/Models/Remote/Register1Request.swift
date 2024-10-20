//
//  Register1Request.swift
//  EMLE Learners
//
//  Created by Abdelrhman Sultan on 15/04/2024.
//

import EMLECore

class Register1Request: CustomRequest {
    
    var endPoint: APIEndPoint { .register1 }
    var method: RequestMethod { .post }
    
    var dto: RequestDTO? { _dto }
    
    let _dto: Register1RequestDTO
    
    init(mobile_code: String, mobile: String, verification_method: String) {
        
        _dto = Register1RequestDTO(mobile_code: mobile_code,
                                   mobile: mobile,
                                   verification_method: verification_method)
    }
}
