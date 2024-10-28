//
//  InvitationMapper.swift
//  EMLE Teams
//
//  Created by iOSAYed on 27/10/2024.
//

import Foundation

extension InvitationDTO {
    func toDomain() -> Invitation {
        return Invitation(invitationId: id, teamName: team_name, invitationStatus: invitation_status, status: status, isInstructor: is_instructor, role: role)
    }
}

extension [InvitationDTO] {
    func toDomain() -> [Invitation] {
        map { $0.toDomain() }
    }
}

extension InvitationActionParameters {
    func toRequest() -> InvitationActionParametersDTO {
        InvitationActionParametersDTO(action: action)
    }
}
