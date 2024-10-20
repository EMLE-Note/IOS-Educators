//
//  LoginResponseDTO.swift
//  EMLE Learners
//
//  Created by Abdelrhman Sultan on 04/04/2024.
//

import EMLECore

class LoginResponseDTO: Codable {
    var id: Int
    var type: TypeResponseDTO?
    var api_token: String?
    var name: String?
    var register_status_numeric: Int?
    var image: String?
    var register_status: String?
    var location: LocationResponseDTO?
    var field: FieldResponseDTO?
}
