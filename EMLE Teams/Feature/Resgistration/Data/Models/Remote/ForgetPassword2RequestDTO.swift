//
//  ForgetPassword2RequestDTO.swift
//  EMLE Learners
//
//  Created by Mustafa Merza on 7/9/24.
//

import EMLECore

struct ForgetPassword2RequestDTO: RequestDTO {
    
    let mobile_code: String
    let mobile: String
    let otp_code: String
}