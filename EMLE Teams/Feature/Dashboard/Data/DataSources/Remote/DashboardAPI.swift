//
//  DashboardAPI.swift
//  EMLE Teams
//
//  Created by iOSAYed on 22/09/2024.
//

import Foundation
import EMLECore

protocol DashboardAPIProtocol: APIProtocol {
    func createTeam(request: CreateTeamRequest) throws -> APIDataPublisher
    func getMyTeams(request: MyTeamsRequestDTO) throws -> APIDataPublisher
}

class DashboardAPI: DashboardAPIProtocol {
 
    var networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    func createTeam(request: CreateTeamRequest) throws -> APIDataPublisher {
        try sendAuthorizedFormAPICall(request: request)
    }
    
    func getMyTeams(request: MyTeamsRequestDTO) throws -> EMLECore.APIDataPublisher {
        try sendAuthorizedFormAPICall(request: request)
    }
}
