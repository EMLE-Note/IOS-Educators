//
//  CreateTeamUseCase.swift
//  EMLE Teams
//
//  Created by iOSAYed on 22/09/2024.
//

import Foundation

class CreateTeamUseCase {
    private let repository: DashboardRepositoryProtocol
    
    init(repository: DashboardRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(params:CreateTeamParameters) throws -> CreateTeamPublisher {
        try repository.createTeam(params: params)
            .toMainThread()
    }
}
