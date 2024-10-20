//
//  ProfileDependencyManager.swift
//  EMLE Learners
//
//  Created by Abdelrhman Sultan on 08/05/2024.
//

import Foundation
import EMLECore

class ProfileDependencyManager {
    
    let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
        
        initializeDependancies()
    }
    
    private func initializeDependancies() {
        
        let api = ProfileAPI(networkManager: networkManager)
        let dataSource = ProfileDataSource(api: api)
        let repository = ProfileRepository(dataSource: dataSource)
        
        @Provide var getProfileDataUseCase = GetProfileDataUseCase(repository: repository)
        @Provide var editProfileUseCase = EditProfileUseCase(repository: repository)
        @Provide var teamPermissionsUseCase = TeamPermissionsUseCase(repository: repository)
        @Provide var memberListUseCase = MemberListUseCase(repository: repository)
        @Provide var getActivationsUseCase = GetActivationsUseCase(repository: repository)
        @Provide var acceptActivationUseCase = AcceptActivationUseCase(repository: repository)
        @Provide var rejectActivationUseCase = RejectActivationUseCase(repository: repository)
        @Provide var acceptAllActivationUseCase = AcceptAllActivationUseCase(repository: repository)
        @Provide var searchStaffUseCase = SearchStaffUseCase(repository: repository)
        @Provide var createEnrollmentCourseUseCase = CreateEnrollmentCourseUseCase(repository: repository)
        @Provide var createEnrollmentQBankUseCase = CreateEnrollmentQBankUseCase(repository: repository)
        @Provide var createEnrollmentEBookUseCase = CreateEnrollmentEBookUseCase(repository: repository)
        @Provide var createEnrollmentMassCourseUseCase = CreateEnrollmentMassCourseUseCase(repository: repository)
    }
}
