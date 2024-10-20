//
//  RegistrationDependencyManager.swift
//  EMLE Learners
//
//  Created by Abdelrhman Sultan on 04/04/2024.
//

import Foundation
import EMLECore

class RegistrationDependencyManager {
    
    let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol) {
        
        self.networkManager = networkManager
        
        initializeDependencies()
    }
    
    private func initializeDependencies() {
        initializeRegistrationDependencies()
    }
    
    private func initializeRegistrationDependencies() {
        
        let registrationAPI = RegistrationAPI(networkManager: networkManager)
        
        let registrationDataSource = RegistrationDataSource(api: registrationAPI)
        
        let registrationRepository = RegistrationRepository(registrationDataSource: registrationDataSource)
        
        initializeRegistrationCases(repository: registrationRepository)
        
    }
    
    private func initializeRegistrationCases(repository: IRegistrationRepository) {
        
        @Provide var signInUseCase = LoginUseCase(repository: repository)
        
        @Provide var register1UseCase = Register1UseCase(repository: repository)
        @Provide var register2UseCase = Register2UseCase(repository: repository)
        @Provide var register3UseCase = Register3UseCase(repository: repository)
        @Provide var register4UseCase = Register4UseCase(repository: repository)
        
        @Provide var forgetPassword1UseCase = ForgetPassword1UseCase(repository: repository)
        @Provide var forgetPassword2UseCase = ForgetPassword2UseCase(repository: repository)
        @Provide var forgetPassword3UseCase = ForgetPassword3UseCase(repository: repository)
    }
}
