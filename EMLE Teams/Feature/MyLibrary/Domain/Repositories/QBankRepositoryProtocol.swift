//
//  QBankRepositoryProtocol.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 02/09/2024.
//

import Foundation
import EMLECore

protocol QBankRepositoryProtocol: RepositoryProtocol {
    func getQBanks(params: GetQBank) throws -> GetQBankPublisher
    func createQBanks(params: CreateQBank) throws -> CreateQBankPublisher
    func getQBankSetting(params: GetQBankSettingParameter) throws -> GetQBankSettingPublisher
    func updateQBankSetting(params: UpdateQBankSettingParameter) throws -> UpdateQBankSettingPublisher
}
