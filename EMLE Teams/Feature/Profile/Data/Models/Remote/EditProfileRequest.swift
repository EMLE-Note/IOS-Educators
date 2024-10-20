//
//  EditProfileRequest.swift
//  EMLE Learners
//
//  Created by Abdelrhman Sultan on 27/05/2024.
//

import Foundation
import EMLECore

class EditProfileRequest: CustomRequest {
    
    var endPoint: APIEndPoint { .getProfile }
    
    var method: RequestMethod { .post }
    
    var formData: FormData? {
        
        if let image  {
            return [
                CodingKeys.name.stringValue : name,
                CodingKeys.field_id.stringValue : field_id,
                CodingKeys.email.stringValue : email,
                CodingKeys.type_id.stringValue : type_id,
                CodingKeys.overview.stringValue: overview,
                CodingKeys.location_id.stringValue: location_id,
                CodingKeys._method.stringValue: _method,
                CodingKeys.graduation_year.stringValue: graduation_year,
                CodingKeys.image.stringValue: image,
            ]
        } else {
            return [
                CodingKeys.name.stringValue : name,
                CodingKeys.field_id.stringValue : field_id,
                CodingKeys.email.stringValue : email,
                CodingKeys.type_id.stringValue : type_id,
                CodingKeys.overview.stringValue: overview,
                CodingKeys.location_id.stringValue: location_id,
                CodingKeys.graduation_year.stringValue: graduation_year,
                CodingKeys._method.stringValue: _method,
            ]
        }
    }
    
    var name: String
    var email: String
    var overview: String
    var location_id: Int
    var field_id: Int
    var type_id: Int
    var _method = "put"
    var graduation_year: String
    var image: Data?
    
    init(name: String, email: String, overview: String, location_id: Int, field_id: Int, type_id: Int, graduation_year: String, image: Data?) {
        self.name = name
        self.email = email
        self.overview = overview
        self.location_id = location_id
        self.field_id = field_id
        self.type_id = type_id
        self.graduation_year = graduation_year
        self.image = image
    }
}
