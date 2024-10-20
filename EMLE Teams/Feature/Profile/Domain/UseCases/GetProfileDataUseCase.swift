//
//  GetProfileDataUseCase.swift
//  EMLE Learners
//
//  Created by Abdelrhman Sultan on 20/05/2024.
//

import Foundation

class GetProfileDataUseCase {
    private let repository: IProfileRepository
    
    init(repository: IProfileRepository) {
        self.repository = repository
    }
    
    func execute() throws -> ProfileDataPublisher {
        try repository.getProfileData()
            .toMainThread()
    }
}
