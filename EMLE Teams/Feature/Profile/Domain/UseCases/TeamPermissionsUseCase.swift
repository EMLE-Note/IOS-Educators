//
//  TeamPermissionsUseCase.swift
//  EMLE Teams
//
//  Created by iOSAYed on 14/09/2024.
//

import Foundation

class TeamPermissionsUseCase {
    let repository: IProfileRepository
    
    init(repository: IProfileRepository) {
        self.repository = repository
    }
    
    func execute() throws -> TeamPermissionsPublisher {
        try repository.getTeamPermissionsData()
            .toMainThread()
    }
}
