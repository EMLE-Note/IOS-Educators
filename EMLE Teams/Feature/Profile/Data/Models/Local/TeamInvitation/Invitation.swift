//
//  Invitation.swift
//  EMLE Teams
//
//  Created by iOSAYed on 27/10/2024.
//

import Foundation

struct Invitation: Identifiable {
    var id = UUID()
    let invitationId: Int
    let teamName: String
    let invitationStatus: Int
    let status: Int
    let isInstructor: Int
    let role: String
}

extension Invitation {
    static let placeholder = Invitation(invitationId: 0, teamName: "", invitationStatus: 0, status: 0, isInstructor: 0, role: "")
}

extension [Invitation] {
    static let placeholder: [Invitation] = {
        var placeholder: [Invitation] = []
        
        for i in 0..<5 {
            placeholder.append(Invitation(invitationId: 0, teamName: "", invitationStatus: 0, status: 0, isInstructor: 0, role: ""))
        }
        
        return placeholder
    }()
}
