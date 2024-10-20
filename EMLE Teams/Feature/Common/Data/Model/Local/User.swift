//
//  User.swift
//  EMLE Learners
//
//  Created by Abdelrhman Sultan on 02/04/2024.
//

import Foundation
import EMLECore

struct User: CoreUserProtocol {
    
    var id: Int
    var token: Token
    var name: String
    var status: RegisterStatus
    
    var isSignedIn: Bool
    var isEmpty: Bool { id == 0 }
    var image: ImageUrl?
    
    var studyingField: StudyingField?
    var location: Location?
    var type: EducationStatus?
    var hasImage: Bool { image != nil }
    
    static var testUser: User? { .dummy }
}

extension User {
    
    static var empty: User = {
        User(id: 0,
             token: Token(token: ""),
             name: "",
             status: .finished,
             isSignedIn: false)
    }()
    
    static var dummy: User = {
        
        let token = Token(token: "1036|C75I95SlrvkFlJlwG5nLxzJNYKooWL6iHH7Qk24ta951baf1")
        
        return User(id: 6,
                    token: token,
                    name: "Elsayed Ahmed",
                    status: .finished,
                    isSignedIn: true)
    }()
}

enum RegisterStatus: Int, Codable {
    case OTPConfirmed = 2
    case notCompleted = 3
    case finished = 4
}
