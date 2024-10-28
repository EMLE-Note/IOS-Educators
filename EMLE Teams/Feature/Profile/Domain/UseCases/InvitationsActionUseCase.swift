//
//  InvitationsActionUseCase.swift
//  EMLE Teams
//
//  Created by iOSAYed on 28/10/2024.
//

import Foundation
import EMLECore

class InvitationsActionUseCase {
    let repository: IProfileRepository
    
    init(repository: IProfileRepository) {
        self.repository = repository
    }
    
    func execute(invitationID: Int, params: InvitationActionParameters) throws -> InvitationActionPublisher {
        try repository.invitationAction(invitationID: invitationID, params: params)
            .toMainThread()
    }
}

