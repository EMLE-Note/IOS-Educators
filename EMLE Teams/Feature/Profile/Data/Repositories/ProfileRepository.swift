//
//  ProfileRepository.swift
//  EMLE Learners
//
//  Created by Abdelrhman Sultan on 19/05/2024.
//

import Foundation
import EMLECore
import Combine

typealias ProfileDataPublisher = DomainPublisher<ProfileData>
typealias EditProfilePublisher = DomainPublisher<User>
typealias TeamPermissionsPublisher = DomainPublisher<TeamPermissions>
typealias MemberListPublisher = DomainPublisher<[Member]>
typealias ActivationPublisher = DomainPublisher<[Activations]>
typealias AcceptActivationPublisher = DomainPublisher<AcceptActivationResponse>
typealias RejectActivationPublisher = DomainPublisher<RejectActivationResponse>
typealias SearchStaffPublisher = DomainPublisher<SearchStaffResponse>
typealias EnrollmentManualPublisher = DomainPublisher<EnrollmentManualResponse>
typealias InvitationListPublisher = DomainPublisher<[Invitation]>
typealias InvitationActionPublisher = DomainPublisher<InvitationActionResponse>

class ProfileRepository: IProfileRepository {
    
    @Inject var changeUserUseCase: ChangeUserUseCase<User>
    
    @Inject var getUserUseCase: GetUserUseCase<User>
    
    private let dataSource: IProfileDataSource
    
    init(dataSource: IProfileDataSource) {
        self.dataSource = dataSource
    }
    
    func getProfileData() throws -> ProfileDataPublisher {
        try dataSource.getProfileDate()
            .tryMap { try self.mapGetProfileResponseDTO(response: $0) }
            .mapError()
            .eraseToAnyPublisher()
    }
    
    func editProfileData(editProfile: EditProfile) throws -> EditProfilePublisher {
        try dataSource.editProfileDate(editProfile: editProfile)
            .tryMap { try self.mapEditProfileResponseDTO(response: $0, editProfile: editProfile) }
            .mapError()
            .eraseToAnyPublisher()
    }
    
    func getTeamPermissionsData() throws -> TeamPermissionsPublisher {
        try dataSource.getTeamPermissions()
            .tryMap { $0.toDomainWrapper(with: $0.data?.toTeamPermissions()) }
            .mapError()
            .eraseToAnyPublisher()
    }
    
    func getMemberListData() throws -> MemberListPublisher {
        try dataSource.getMemberList()
            .tryMap { $0.toDomainWrapper(with: $0.data?.toMemberList()) }
            .mapError()
            .eraseToAnyPublisher()
    }
    
    func getActivationsData() throws -> ActivationPublisher {
        try dataSource.getActivation()
            .tryMap { $0.toDomainWrapper(with: $0.data?.toDomain()) }
            .mapError()
            .eraseToAnyPublisher()
    }
    
    func acceptActivationsData(activationID: Int) throws -> AcceptActivationPublisher {
        try dataSource.acceptActivation(activationID: activationID)
            .tryMap { $0.toDomainWrapper(with: nil) }
            .mapError()
            .eraseToAnyPublisher()
    }
    
    func acceptAllActivationsData(activationID: [Int]) throws -> AcceptActivationPublisher {
        try dataSource.acceptAllActivation(activationID: activationID)
            .tryMap { $0.toDomainWrapper(with: nil) }
            .mapError()
            .eraseToAnyPublisher()
    }
    
    func rejectActivationsData(activationID: Int) throws -> RejectActivationPublisher {
        try dataSource.rejectActivation(activationID: activationID)
            .tryMap { $0.toDomainWrapper(with: nil) }
            .mapError()
            .eraseToAnyPublisher()
    }
    
    func searchStaff(parms: SearchStaffParameter) throws -> SearchStaffPublisher {
        try dataSource.searchStaff(params: parms)
            .tryMap { $0.toDomainWrapper(with: $0.data?.toDomain()) }
            .mapError()
            .eraseToAnyPublisher()
    }
    
    func createEnrollmentCourse(parms: EnrollmentCourse) throws -> EnrollmentManualPublisher {
        try dataSource.createEnrollmentCourse(params: parms)
            .tryMap {  $0.toDomainWrapper(with: nil) }
            .mapError()
            .eraseToAnyPublisher()
    }
    
    func createEnrollmentQBank(parms: EnrollmentCourse) throws -> EnrollmentManualPublisher {
        try dataSource.createEnrollmentQBank(params: parms)
            .tryMap {  $0.toDomainWrapper(with: nil) }
            .mapError()
            .eraseToAnyPublisher()
    }
    
    func createEnrollmentEBook(parms: EnrollmentCourse) throws -> EnrollmentManualPublisher {
        try dataSource.createEnrollmentEBook(params: parms)
            .tryMap {  $0.toDomainWrapper(with: nil) }
            .mapError()
            .eraseToAnyPublisher()
    }
    
    func createEnrollmentMassCourse(parms: EnrollmentCourseParameter) throws -> EnrollmentManualPublisher {
        try dataSource.createEnrollmentMassCourse(params: parms)
            .tryMap {  $0.toDomainWrapper(with: nil) }
            .mapError()
            .eraseToAnyPublisher()
    }
    
    func getInvitationsListData() throws -> InvitationListPublisher {
        try dataSource.getInvitationList()
            .tryMap { $0.toDomainWrapper(with: $0.data?.toDomain()) }
            .mapError()
            .eraseToAnyPublisher()
    }
    
    func invitationAction(invitationID: Int, params: InvitationActionParameters) throws -> InvitationActionPublisher {
        try dataSource.invitationAction(invitationID: invitationID, params: params)
            .tryMap { $0.toDomainWrapper(with: nil) }
            .mapError()
            .eraseToAnyPublisher()
    }
}

extension ProfileRepository {
    
    private func mapGetProfileResponseDTO(response: ResponseDTO<GetProfileInfoResponseDTO>) throws -> DomainWrapper<ProfileData> {
        
        let profileData = response.data?.toDomain()
        let oldUser = getUserUseCase.execute()
        
        if response.isSuccess, let profileData, let oldUser {
            
            var newUser = profileData.toUser()
            newUser.id = oldUser.id
            newUser.token = oldUser.token
            newUser.status = oldUser.status
            newUser.isSignedIn = oldUser.isSignedIn
            
            changeUserUseCase.execute(with: newUser)
        }
        
        return response.toDomainWrapper(with: profileData)
    }
    
    private func mapEditProfileResponseDTO(response: ResponseDTO<EditProfileResponseDTO>, editProfile: EditProfile) throws -> DomainWrapper<User> {
        
        let user = try response.data?.toDomain()
        
        let oldUser = getUserUseCase.execute()
        
        if response.isSuccess, var user, let oldUser {
            
            user.token = oldUser.token
            changeUserUseCase.execute(with: user)
        }
        return response.toDomainWrapper(with: user)
    }
}
