//
//  SecretaryMapper.swift
//  EMLE Teams
//
//  Created by iOSAYed on 26/07/2024.
//

import Foundation

extension [SecretaryDTO] {
    func toDomain() throws -> [Secretary] {
        try map { $0.toDomain()}
    }
}
