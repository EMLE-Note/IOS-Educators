//
//  MyTeamsMapper.swift
//  EMLE Teams
//
//  Created by iOSAYed on 27/09/2024.
//

import Foundation

extension GetMyTeamsResponseDTO {
    func toDomain() -> [Team] {
       return data.toDomain()
    }
}
