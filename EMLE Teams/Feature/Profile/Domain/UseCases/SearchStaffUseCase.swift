//
//  SearchStaffUseCase.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 14/10/2024.
//

import Foundation

class SearchStaffUseCase {
    let repository: IProfileRepository
    
    init(repository: IProfileRepository) {
        self.repository = repository
    }
    
    func execute(parms: SearchStaffParameter) throws -> SearchStaffPublisher {
        try repository.searchStaff(parms: parms)
            .toMainThread()
    }
}
