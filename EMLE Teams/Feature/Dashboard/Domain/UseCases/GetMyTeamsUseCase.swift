//
//  GetMyTeamsUseCase.swift
//  EMLE Teams
//
//  Created by iOSAYed on 27/09/2024.
//

import Foundation
import EMLECore

class GetMyTeamsUseCase {
    private let repository: DashboardRepositoryProtocol
    
    init(repository: DashboardRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() throws -> GetMyTeamsPublisher {
        try repository.getMyTeams()
            .toMainThread()
    }
}
