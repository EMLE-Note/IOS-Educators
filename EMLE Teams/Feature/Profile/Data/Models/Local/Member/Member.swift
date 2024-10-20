//
//  Member.swift
//  EMLE Teams
//
//  Created by iOSAYed on 20/09/2024.
//

import EMLECore
import Foundation

struct Member: Codable {
    var id = UUID()
    let memberId: Int
    let name: String
    let image: ImageUrl?
    let mobileCode, mobile, role: String
    let isInstructor, status, invitationStatus: Int
    let team: String
    let teamID: Int
    let createdAt, updatedAt: String
//    let permissions: [Permissions]
}

extension Member {
    
    static let placeholder = Member(memberId: 0, name: "", image: ImageUrl(urlString: ""), mobileCode: "", mobile: "", role: "", isInstructor: 0, status: 0, invitationStatus: 0, team: "", teamID: 0, createdAt: "", updatedAt: "")
}

extension [Member] {
    static let placeholder: [Member] = {
        var placeholder: [Member] = []
        
        for i in 0..<4 {
            placeholder.append(.placeholder)
        }
        return placeholder
    }()
}
