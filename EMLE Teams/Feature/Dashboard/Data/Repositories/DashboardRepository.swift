//
//  DashboardRepository.swift
//  EMLE Teams
//
//  Created by iOSAYed on 22/09/2024.
//

import Foundation
import EMLECore

typealias CreateTeamPublisher = DomainPublisher<CreateTeam>
typealias GetMyTeamsPublisher = DomainPublisher<[Team]>

class DashboardRepository: DashboardRepositoryProtocol {
  
    private let dataSource: DashboardDataSourceProtocol
    
    init(dataSource: DashboardDataSourceProtocol) {
        self.dataSource = dataSource
    }
    
    func createTeam(params: CreateTeamParameters) throws -> CreateTeamPublisher {
        try dataSource.createTeam(params: params)
            .tryMap { try $0.toDomainWrapper(with: $0.data?.toDomain()) }
            .mapError()
            .eraseToAnyPublisher()
    }
    
    func getMyTeams() throws -> GetMyTeamsPublisher {
        try dataSource.getMyTeams()
            .tryMap { try $0.toDomainWrapper(with: $0.data?.toDomain()) }
            .mapError()
            .eraseToAnyPublisher()
    }
    
  
}
