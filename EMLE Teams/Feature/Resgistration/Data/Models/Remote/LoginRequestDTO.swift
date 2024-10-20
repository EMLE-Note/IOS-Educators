//
//  LoginRequestDTO.swift
//  EMLE Learners
//
//  Created by Mustafa Merza on 7/9/24.
//

import EMLECore

struct LoginRequestDTO: RequestDTO {
    
    let mobile_code: String
    let mobile: String
    let password: String
    let fb_token: String
}
