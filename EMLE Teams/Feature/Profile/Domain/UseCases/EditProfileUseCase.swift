//
//  EditProfileUseCase.swift
//  EMLE Learners
//
//  Created by Abdelrhman Sultan on 27/05/2024.
//

import Foundation

class EditProfileUseCase {
    let repository: IProfileRepository
    
    init(repository: IProfileRepository) {
        self.repository = repository
    }
    
    func execute(with editProfile: EditProfile) throws -> EditProfilePublisher {
        try repository.editProfileData(editProfile: editProfile)
            .toMainThread()
    }
}
