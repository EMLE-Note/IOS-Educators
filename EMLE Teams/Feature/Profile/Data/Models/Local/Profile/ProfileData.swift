//
//  ProfileData.swift
//  EMLE Learners
//
//  Created by Abdelrhman Sultan on 11/05/2024.
//

import Foundation
import EMLECore

struct ProfileData {
    var id: Int
    var type: EducationStatus?
    var name: String
    var image: ImageUrl?
    var registerStatus: String
    var registerStatusNumeric: Int
    var jobTitle: String
    var teams: [Team]
    var overview: String?
    var mobileCode: String
    var mobile: String
    var email: String
    var field: StudyingField
    var location: Location
    
    var mobileCodeWithoutPlus: String { mobileCode.first == "+" ? String(mobileCode.dropFirst()) : mobileCode }
}

extension ProfileData {
    static let placeholder = ProfileData(id: 0, name: "Elsayed Ahmed", registerStatus: "", registerStatusNumeric: 0, jobTitle: "", teams: .placeholder, overview: "", mobileCode: "", mobile: "", email: "", field: .placeholder, location: .placeholder)
}
