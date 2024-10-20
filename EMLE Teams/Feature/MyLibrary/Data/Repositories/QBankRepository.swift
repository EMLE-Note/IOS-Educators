//
//  QBankRepository.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 02/09/2024.
//

import Foundation
import Combine
import EMLECore

typealias GetQBankPublisher = DomainPublisher<QBankResponse>
typealias CreateQBankPublisher = DomainPublisher<CreateQBankResponse>
typealias GetQBankSettingPublisher = DomainPublisher<QBank>
typealias UpdateQBankSettingPublisher = DomainPublisher<UpdateQBankSettingResponse>

class QBankRepository: QBankRepositoryProtocol {
 
    private let dataSource: QBanksRemoteDataSourceProtocol
    
    init(dataSource: QBanksRemoteDataSourceProtocol) {
        self.dataSource = dataSource
    }
   
    func getQBanks(params: GetQBank) throws -> GetQBankPublisher {
        try dataSource.getQBanks(params: params)
            .tryMap { $0.toDomainWrapper(with: try $0.data?.toDomain()) }
            .mapError()
            .eraseToAnyPublisher()
    }
    
    func createQBanks(params: CreateQBank) throws -> CreateQBankPublisher {
        try dataSource.createQBank(params: params)
            .tryMap { $0.toDomainWrapper(with: try $0.data?.toDomain()) }
            .mapError()
            .eraseToAnyPublisher()
    }
    
    func getQBankSetting(params: GetQBankSettingParameter) throws -> GetQBankSettingPublisher {
        try dataSource.getQBankSetting(params: params)
            .tryMap { $0.toDomainWrapper(with: try $0.data?.toDomain()) }
            .mapError()
            .eraseToAnyPublisher()
    }
    
    func updateQBankSetting(params: UpdateQBankSettingParameter) throws -> UpdateQBankSettingPublisher {
        try dataSource.updateQBankSetting(params: params)
            .tryMap { $0.toDomainWrapper(with: try $0.data?.toDomain()) }
            .mapError()
            .eraseToAnyPublisher()
    }
}
