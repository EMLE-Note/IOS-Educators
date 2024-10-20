//
//  Register3RequestDTO.swift
//  EMLE Learners
//
//  Created by Mustafa Merza on 7/9/24.
//

import EMLECore

struct Register3RequestDTO: RequestDTO {
    
    let mobile_code: String
    let mobile: String
    let otp_code: String
    let password: String
    let password_confirmation: String
}
