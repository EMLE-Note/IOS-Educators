//
//  ActivationMapper.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 12/10/2024.
//

import Foundation

extension ActivationsDTO {
    func toDomain() -> Activations {
        return Activations(activationID: id, type: type, registrationID: registration_id, registrationName: registration_name, paidAmount: paid_amount, student: student.toDomain(), requestable: requestable.toDomain(), createdAt: created_at)
    }
}

extension [ActivationsDTO] {
    func toDomain() -> [Activations] {
        map { $0.toDomain() }
    }
}

extension RequestableDTO {
    func toDomain() -> Requestable {
        return Requestable(id: id, name: name)
    }
}
