//
//  LoginRequest.swift
//  EMLE Learners
//
//  Created by Abdelrhman Sultan on 04/04/2024.
//

import EMLECore

class LoginRequest: CustomRequest {
    
    var endPoint: APIEndPoint { .login }
    var method: RequestMethod { .post }
    
    var dto: RequestDTO? { _dto }
    
    let _dto: LoginRequestDTO
    
    init(mobile_code: String, mobile: String, password: String, fb_token: String) {
        
        _dto = LoginRequestDTO(mobile_code: mobile_code,
                               mobile: mobile,
                               password: password,
                               fb_token: fb_token)
    }
}
