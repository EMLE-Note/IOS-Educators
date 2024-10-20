//
//  DashboardRepositoryProtocol.swift
//  EMLE Teams
//
//  Created by iOSAYed on 22/09/2024.
//

import Foundation
import EMLECore

protocol DashboardRepositoryProtocol: RepositoryProtocol {
    func createTeam(params: CreateTeamParameters) throws -> CreateTeamPublisher
    func getMyTeams() throws -> GetMyTeamsPublisher

}
