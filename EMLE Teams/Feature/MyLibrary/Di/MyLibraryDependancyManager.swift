//
//  MyLibraryDependancyManager.swift
//  EMLE Teams
//
//  Created by iOSAYed on 16/08/2024.
//

import Foundation
import EMLECore

class MyLibraryDependancyManager {
    
    let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
        
        initializeCoursesDependancies()
        initializeQBankDependencies()
    }
    
    func initializeCoursesDependancies(){
        let api = LibraryAPI(networkManager: networkManager)
        let dataSource = LibraryDataSource(api: api)
        let LibraryRepository = LibraryRepository(dataSource: dataSource)
        
        @Provide var libraryDataUseCase = LibraryDataUseCase(repository: LibraryRepository)
        @Provide var contentDataUseCase = ContentDataUseCase(repository: LibraryRepository)
        @Provide var studentDataUseCase = StudentDataUseCase(repository: LibraryRepository)
        @Provide var childernFolderUseCase = ChildernFolderUseCase(repository: LibraryRepository)
        @Provide var editCourseUseCase = EditCourseUseCase(repository: LibraryRepository)
        @Provide var createCourseUseCase = CreateCourseUseCase(repository: LibraryRepository)
        @Provide var editCourseSecurityUseCase = EditCourseSecurityUseCase(repository: LibraryRepository)
        @Provide var editCourseTargetUseCase = EditCourseTargetUseCase(repository: LibraryRepository)
        @Provide var createGroupUseCase = CreateGroupUseCase(repository: LibraryRepository)
        @Provide var getGroupUseCase = GetGroupUseCase(repository: LibraryRepository)
        @Provide var deleteGroupUseCase = DeleteGroupUseCase(repository: LibraryRepository)
        @Provide var uploadVideoUseCase = UploadVideoUseCase(repository: LibraryRepository)
        @Provide var editMaterilUseCase = EditMaterilUseCase(repository: LibraryRepository)
        @Provide var copyMaterilUseCase = CopyMaterilUseCase(repository: LibraryRepository)

    }
    
    private func initializeQBankDependencies() {
        
        let api = QBanksAPI(networkManager: networkManager)
        let dataSource = QBanksRemoteDataSource(api: api)
        let repository = QBankRepository(dataSource: dataSource)
        
        @Provide var qBankUseCase = QBankUseCase(repository: repository)
        @Provide var createQBankUseCase = CreateQBankUseCase(repository: repository)
        @Provide var qetQBankSettingUseCase = GetQBankSettingUseCase(repository: repository)
        @Provide var updateQBankSettingUseCase = UpdateQBankSettingUseCase(repository: repository)
    }
    
}
