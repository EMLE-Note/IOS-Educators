//
//  InvitationsUseCase.swift
//  EMLE Teams
//
//  Created by iOSAYed on 27/10/2024.
//

import Foundation
import EMLECore

class GetInvitationsListUseCase {
    let repository: IProfileRepository
    
    init(repository: IProfileRepository) {
        self.repository = repository
    }
    
    func execute() throws -> InvitationListPublisher {
        try repository.getInvitationsListData()
            .toMainThread()
    }
}
