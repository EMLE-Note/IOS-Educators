//
//  Register4Request.swift
//  EMLE Learners
//
//  Created by Abdelrhman Sultan on 25/04/2024.
//

import Foundation
import EMLECore

class Register4Request: CustomRequest {
    var endPoint: APIEndPoint { .register4 }
    var method: RequestMethod { .post }
    
    var formData: FormData? {
        
        if let image  {
            return [
                CodingKeys.name.stringValue : name,
                CodingKeys.field_id.stringValue : field_id,
                CodingKeys.job_title.stringValue:job_title,
                CodingKeys.overview.stringValue:overview,
                CodingKeys.type_id.stringValue : type_id,
                CodingKeys.image.stringValue: image
            ]
        } else {
            return [
                CodingKeys.name.stringValue : name,
                CodingKeys.field_id.stringValue : field_id,
                CodingKeys.job_title.stringValue:job_title,
                CodingKeys.overview.stringValue:overview,
                CodingKeys.type_id.stringValue : type_id
            ]
        }
    }
    
    let name: String
    let field_id: Int
    let job_title: String
    let overview: String
    let type_id: Int
    let image: Data?
    
    init(name: String, field_id: Int, type_id: Int, image: Data?,job_title:String,overview:String) {
        self.name = name
        self.field_id = field_id
        self.job_title = job_title
        self.overview = overview
        self.type_id = type_id
        self.image = image
    }
}
