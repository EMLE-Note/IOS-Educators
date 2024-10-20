//
//  DasboardDependencyManager.swift
//  EMLE Teams
//
//  Created by iOSAYed on 04/08/2024.
//

import Foundation
import EMLECore

class DasboardDependencyManager {
    
    let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
        
        initializeDependancies()
    }
    
    func initializeDependancies(){
        let api = DashboardAPI(networkManager: networkManager)
        let dataSource = DashboardDataSource(api: api)
        let DashboardRepository = DashboardRepository(dataSource: dataSource)
        
        @Provide var createTeamUseCase = CreateTeamUseCase(repository: DashboardRepository)
        @Provide var getMyTeamsUseCase = GetMyTeamsUseCase(repository: DashboardRepository)

    }
    
}
