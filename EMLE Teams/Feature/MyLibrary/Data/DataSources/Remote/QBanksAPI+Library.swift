//
//  QBanksAPI+Library.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 02/09/2024.
//

import Foundation
import EMLECore

protocol QBanksAPIProtocol: APIProtocol {
    func getQBanks(request: GetQBankRequest) throws -> APIDataPublisher
    func createQBanks(request: CreateQBankRequest) throws -> APIDataPublisher
    func getQBankSetting(request: GetSettingQBankRequest) throws -> APIDataPublisher
    func updateQBankSetting(request: UpdateQBankSettingRequest) throws -> APIDataPublisher
}

class QBanksAPI: QBanksAPIProtocol {
    var networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    func getQBanks(request: GetQBankRequest) throws -> APIDataPublisher {
        return try sendTeamAuthorizedAPICall(request: request)
    }
    
    func createQBanks(request: CreateQBankRequest) throws -> APIDataPublisher {
        return try sendTeamAuthorizedFormAPICall(request: request)
    }

    func getQBankSetting(request: GetSettingQBankRequest) throws -> APIDataPublisher {
        return try sendTeamAuthorizedAPICall(request: request)
    }
    
    func updateQBankSetting(request: UpdateQBankSettingRequest) throws -> APIDataPublisher {
        return try sendTeamAuthorizedFormAPICall(request: request)
    }
}
