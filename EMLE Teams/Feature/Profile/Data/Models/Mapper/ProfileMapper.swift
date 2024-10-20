//
//  ProfileMapper.swift
//  EMLE Learners
//
//  Created by Abdelrhman Sultan on 19/05/2024.
//

import Foundation
import EMLECore

extension GetProfileInfoResponseDTO {
    func toDomain() -> ProfileData {
        var imageUrl: ImageUrl? = nil
        
        if let image {
            imageUrl = ImageUrl(urlString: image)
        }
        
        return ProfileData(id: id,
                           type: type == nil ? nil : EducationStatus(educationStatusId: type?.id ?? 0, name: type?.name ?? ""),
                           name: name,
                           image: imageUrl, registerStatus: register_status,
                           registerStatusNumeric: register_status_numeric,
                           jobTitle: job_title,
                           teams: teams.toDomain(),
                           overview: overview,
                           mobileCode: mobile_code,
                           mobile: mobile,
                           email: email ?? "",
                           field: field?.toDomain(parentId: nil) ?? .placeholder,
                           location: locations?.toDomain() ?? .placeholder)
    }
}

extension EditProfile {
    func toRequest() -> EditProfileRequest {
        EditProfileRequest(name: name,
                           email: email,
                           overview: overview,
                           location_id: locationId,
                           field_id: fieldId,
                           type_id: typeId,
                           graduation_year: graduationYear,
                           image: image)
    }
}

extension ProfileData {
    func toUser() -> User {
        User(id: 1,
             token: .init(token: ""),
             name: self.name,
             status: .finished,
             isSignedIn: true,
             image: self.image,
             studyingField: self.field,
             location: self.location)
    }
}

extension [TeamDTO] {
    func toDomain() -> [Team] {
         map { $0.toDomain()}
    }
}

extension OwnerDTO {
    func toDomain() -> Owner {
        var imageUrl: ImageUrl? = nil
        
        if let image {
            imageUrl = ImageUrl(urlString: image)
        }
        return Owner(id: id, name: name, image: imageUrl, overview: overview, jobTitle: job_title, field: field.toDomain(parentId: nil))
    }
}
