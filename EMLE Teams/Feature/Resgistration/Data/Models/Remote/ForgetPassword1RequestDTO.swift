//
//  ForgetPassword1RequestDTO.swift
//  EMLE Learners
//
//  Created by Mustafa Merza on 7/9/24.
//

import EMLECore

struct ForgetPassword1RequestDTO: RequestDTO {
    
    let mobile_code: String
    let mobile: String
    let verification_method: String
}