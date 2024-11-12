//
//  DependencyManager.swift
//  EMLE Teams
//
//  Created by iOSAYed on 08/06/2024.
//

import Foundation
import EMLECore

struct DependencyManager: DependencyManagerProtocol {
    
    typealias U = User
    
    static let main = DependencyManager()
    
    var networkManager: NetworkManagerProtocol = AlamofireNetworkManager()
    
    var userDefaultsManager = UserDefaultsManager()
    
    private init() {
        initializeDependencies()
    }
    
    func initializeFeaturesDependencies() {
        _ = RegistrationDependencyManager(networkManager: networkManager)
        
        _ = ProfileDependencyManager(networkManager: networkManager)

        _ = FinanceDependancyManager(networkManager: networkManager)
        _ = DasboardDependencyManager(networkManager: networkManager)
        _ = MyLibraryDependancyManager(networkManager: networkManager)
        
    }
    
    func initializeServicesDependencies() {
        @Provide var monitorStatusService = MonitorStatusService()
    }
    
    func initializeOtherDependencies() {
        @Provide var teamId = TeamId(id: 17)
        @Provide var token = Token(token: "1085|4yWj4TA4gWjYRey43ICEaLRP1fDcVaXaAsrfrPP3588a679c")
        
    }
}
