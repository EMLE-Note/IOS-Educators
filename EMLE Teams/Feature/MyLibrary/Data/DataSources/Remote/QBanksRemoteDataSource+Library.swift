//
//  QBanksRemoteDataSource+Library.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 02/09/2024.
//

import Foundation
import Combine
import EMLECore

typealias GetQBankResponsePublisher = ResponsePublisher<GetQBankResponseDTO>
typealias CreateQBankResponsePublisher = ResponsePublisher<CreateQBankResponseDTO>
typealias GetQBankSettingResponsePublisher = ResponsePublisher<QBankDTO>
typealias UpdateQBankSettingResponsePublisher = ResponsePublisher<UpdateQBankSettingResponseDTO>

protocol QBanksRemoteDataSourceProtocol: RemoteDataSourceProtocol {
    func getQBanks(params: GetQBank) throws -> GetQBankResponsePublisher
    func createQBank(params: CreateQBank) throws -> CreateQBankResponsePublisher
    func getQBankSetting(params: GetQBankSettingParameter) throws -> GetQBankSettingResponsePublisher
    func updateQBankSetting(params: UpdateQBankSettingParameter) throws -> UpdateQBankSettingResponsePublisher
}

class QBanksRemoteDataSource: QBanksRemoteDataSourceProtocol {
    
    private let api: QBanksAPIProtocol
    
    init(api: QBanksAPIProtocol) {
        self.api = api
    }
    
    func getQBanks(params: GetQBank) throws -> GetQBankResponsePublisher {
        try api.getQBanks(request: params.toRequest())
            .toResponsePublisher()
    }
    
    func createQBank(params: CreateQBank) throws -> CreateQBankResponsePublisher {
        try api.createQBanks(request: params.toRequest())
            .toResponsePublisher()
    }
    
    func getQBankSetting(params: GetQBankSettingParameter) throws -> GetQBankSettingResponsePublisher {
        try api.getQBankSetting(request: params.toRequest())
            .toResponsePublisher()
    }
    
    func updateQBankSetting(params: UpdateQBankSettingParameter) throws -> UpdateQBankSettingResponsePublisher {
        try api.updateQBankSetting(request: params.toRequest())
            .toResponsePublisher()
    }
}
