//
//  DashboardDataSource.swift
//  EMLE Teams
//
//  Created by iOSAYed on 22/09/2024.
//

import Foundation
import Combine
import EMLECore

typealias CreateTeamResponsePublisher = ResponsePublisher<CreateTeamResponseDTO>
typealias GetMyTeamResponsePublisher = ResponsePublisher<[TeamDTO]>

protocol DashboardDataSourceProtocol: RemoteDataSourceProtocol {
    func createTeam(params: CreateTeamParameters) throws -> CreateTeamResponsePublisher
    func getMyTeams() throws -> GetMyTeamResponsePublisher
}

class DashboardDataSource: DashboardDataSourceProtocol {
    private let api: DashboardAPIProtocol
    
    init(api: DashboardAPIProtocol) {
        self.api = api
    }
    
    func createTeam(params: CreateTeamParameters) throws -> CreateTeamResponsePublisher {
        try api.createTeam(request: params.toRequest())
            .toResponsePublisher()
    }
    
    func getMyTeams() throws -> GetMyTeamResponsePublisher {
        try api.getMyTeams(request: MyTeamsRequestDTO())
            .toResponsePublisher()
    }
    
}
