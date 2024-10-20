//
//  ProfileDataSource.swift
//  EMLE Learners
//
//  Created by Abdelrhman Sultan on 19/05/2024.
//

import Foundation
import EMLECore
import Combine

typealias ProfileDataResponsePublisher = ResponsePublisher<GetProfileInfoResponseDTO>
typealias TeamPermissionsDataResponsePublisher = ResponsePublisher<GetTeamPermissionResponseDTO>
typealias EditProfileDataResponsePublisher = ResponsePublisher<EditProfileResponseDTO>
typealias MemberListDataResponsePublisher = ResponsePublisher<GetMemberResponseDTO>
typealias ActivationDataResponsePublisher = ResponsePublisher<[ActivationsDTO]>
typealias AcceptActivationDataResponsePublisher = ResponsePublisher<AcceptActivationRequest>
typealias RejectActivationDataResponsePublisher = ResponsePublisher<RejectActivationRequest>
typealias SearchStaffDataResponsePublisher = ResponsePublisher<SearchStaffResponseDTO>
typealias EnrollmentResponsePublisher = ResponsePublisher<EnrollmentResponseDTO>

protocol IProfileDataSource: RemoteDataSourceProtocol {
    func getProfileDate() throws -> ProfileDataResponsePublisher
    func editProfileDate(editProfile: EditProfile) throws -> EditProfileDataResponsePublisher
    func getTeamPermissions() throws -> TeamPermissionsDataResponsePublisher
    func getMemberList() throws -> MemberListDataResponsePublisher
    func getActivation() throws -> ActivationDataResponsePublisher
    func acceptActivation(activationID: Int) throws -> AcceptActivationDataResponsePublisher
    func acceptAllActivation(activationID: [Int]) throws -> AcceptActivationDataResponsePublisher
    func rejectActivation(activationID: Int) throws -> RejectActivationDataResponsePublisher
    func searchStaff(params: SearchStaffParameter) throws -> SearchStaffDataResponsePublisher
    func createEnrollmentCourse(params: EnrollmentCourse) throws -> EnrollmentResponsePublisher
    func createEnrollmentQBank(params: EnrollmentCourse) throws -> EnrollmentResponsePublisher
    func createEnrollmentEBook(params: EnrollmentCourse) throws -> EnrollmentResponsePublisher
    func createEnrollmentMassCourse(params: EnrollmentCourseParameter) throws -> EnrollmentResponsePublisher
}

class ProfileDataSource: IProfileDataSource {
    
    private let api: IProfileAPI
    
    init(api: IProfileAPI) {
        self.api = api
    }
    
    func getProfileDate() throws -> ProfileDataResponsePublisher {
        try api.getProfileDataRequest(request: GetProfileInfoRequest())
            .toResponsePublisher()
    }
    
    func editProfileDate(editProfile: EditProfile) throws -> EditProfileDataResponsePublisher {
        try api.editProfileDataRequest(request: editProfile.toRequest())
            .toResponsePublisher()
    }
    
    func getTeamPermissions() throws -> TeamPermissionsDataResponsePublisher {
        try api.getTeamPermissions(request: TeamPermissionsRequest())
            .toResponsePublisher()
    }
    
    func getMemberList() throws -> MemberListDataResponsePublisher {
        try api.getMemberList(request: MemberListRequest())
            .toResponsePublisher()
    }
    
    func getActivation() throws -> ActivationDataResponsePublisher {
        try api.getActivation(request: ActivationsRequest())
            .toResponsePublisher()
    }
    
    func acceptActivation(activationID: Int) throws -> AcceptActivationDataResponsePublisher {
        try api.acceptActivation(activationID: activationID)
            .toResponsePublisher()
    }
    
    func acceptAllActivation(activationID: [Int]) throws -> AcceptActivationDataResponsePublisher {
        try api.acceptAllActivation(activationID: activationID)
            .toResponsePublisher()
    }
    
    func rejectActivation(activationID: Int) throws -> RejectActivationDataResponsePublisher {
        try api.rejectActivation(activationID: activationID)
            .toResponsePublisher()
    }
    
    func searchStaff(params: SearchStaffParameter) throws -> SearchStaffDataResponsePublisher {
        try api.searchStaff(request: params.toRequest())
            .toResponsePublisher()
    }
    
    func createEnrollmentCourse(params: EnrollmentCourse) throws -> EnrollmentResponsePublisher {
        try api.createEnrollmentCourse(request: params.toRequest())
            .toResponsePublisher()
    }
    
    func createEnrollmentQBank(params: EnrollmentCourse) throws -> EnrollmentResponsePublisher {
        try api.createEnrollmentQBank(request: params.toRequest())
            .toResponsePublisher()
    }
    
    func createEnrollmentEBook(params: EnrollmentCourse) throws -> EnrollmentResponsePublisher {
        try api.createEnrollmentEBook(request: params.toRequest())
            .toResponsePublisher()
    }
    
    func createEnrollmentMassCourse(params: EnrollmentCourseParameter) throws -> EnrollmentResponsePublisher {
        try api.createEnrollmentMassCourse(request: params.toRequest())
            .toResponsePublisher()
    }
}
