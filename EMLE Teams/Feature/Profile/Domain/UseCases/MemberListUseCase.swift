//
//  MemberListUseCase.swift
//  EMLE Teams
//
//  Created by iOSAYed on 20/09/2024.
//

import Foundation

class MemberListUseCase {
    let repository: IProfileRepository
    
    init(repository: IProfileRepository) {
        self.repository = repository
    }
    
    func execute() throws -> MemberListPublisher {
        try repository.getMemberListData()
            .toMainThread()
    }
}
