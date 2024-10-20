//
//  CreateTeamMapper.swift
//  EMLE Teams
//
//  Created by iOSAYed on 22/09/2024.
//

import Foundation
import EMLECore


extension CreateTeamResponseDTO {
    func toDomain() -> CreateTeam {
        var imageUrl: ImageUrl? = nil
        
        if let image {
            imageUrl = ImageUrl(urlString: image)
        }
        return CreateTeam(id: id, name: name, type: type, about: about, image: imageUrl, createdAt: created_at, updatedAt: updated_at)
    }
}
extension CreateTeamParameters {
    func toRequest() -> CreateTeamRequest {
        CreateTeamRequest(name: name, type: type, about: about, image: image)
    }
}

extension TeamOwnerDTO {
    func toDomain() -> TeamOwner {
       TeamOwner(id: id, type: type, typeID: type_id, name: name, mobileCode: mobile_code, mobile: mobile, email: email, image: image, countryID: country_id, cityID: city_id, appVersion: app_version, learningType: learning_type, avaterID: avater_id, status: status, registerStatus: register_status, emailVerifiedAt: email_verified_at, createdAt: created_at, updatedAt: updated_at, fullMobile: full_mobile)
    }
}


