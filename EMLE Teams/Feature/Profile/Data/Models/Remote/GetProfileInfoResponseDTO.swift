//
//  GetProfileInfoResponseDTO.swift
//  EMLE Learners
//
//  Created by Abdelrhman Sultan on 19/05/2024.
//

import EMLECore

class GetProfileInfoResponseDTO: Codable {
    
    let id: Int
    let type: TypeResponseDTO?
    let name: String
    let register_status: String
    let register_status_numeric: Int
    let job_title: String
    let teams: [TeamDTO]
    let overview: String?
    let image: String?
    let mobile_code: String
    let mobile: String
    let email: String?
    let field: FieldResponseDTO?
    let locations: LocationResponseDTO?
}

