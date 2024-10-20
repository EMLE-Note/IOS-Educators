//
//  CreateTeamRequest.swift
//  EMLE Teams
//
//  Created by iOSAYed on 22/09/2024.
//

import Foundation
import EMLECore

class CreateTeamRequest: CustomRequest {
    var endPoint: APIEndPoint { .createTeam }
    var method: RequestMethod { .post }
    
    var formData: FormData? {
        
        if let image  {
            return [
                CodingKeys.name.stringValue : name,
                CodingKeys.type.stringValue : type,
                CodingKeys.about.stringValue:about,
                CodingKeys.image.stringValue: image
            ]
        } else {
            return [
                CodingKeys.name.stringValue : name,
                CodingKeys.type.stringValue : type,
                CodingKeys.about.stringValue:about
            ]
        }
    }
    
    let name: String
    let type: String
    let about: String
    let image: Data?
    
    init(name: String, type: String, about: String, image: Data?) {
        self.name = name
        self.type = type
        self.about = about
        self.image = image
    }
}
