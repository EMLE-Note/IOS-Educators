//
//  ProfileAPI.swift
//  EMLE Learners
//
//  Created by Abdelrhman Sultan on 19/05/2024.
//

import Foundation
import EMLECore

protocol IProfileAPI: APIProtocol {
    func getProfileDataRequest(request: GetProfileInfoRequest) throws -> APIDataPublisher
    func editProfileDataRequest(request: EditProfileRequest) throws -> APIDataPublisher
    func getTeamPermissions(request: TeamPermissionsRequest) throws -> APIDataPublisher
    func getMemberList(request: MemberListRequest) throws -> APIDataPublisher
    func getActivation(request: ActivationsRequest) throws -> APIDataPublisher
    func acceptActivation(activationID: Int) throws -> APIDataPublisher
    func acceptAllActivation(activationID: [Int]) throws -> APIDataPublisher
    func rejectActivation(activationID: Int) throws -> APIDataPublisher
    func searchStaff(request: SearchStaffRequest) throws -> APIDataPublisher
    func createEnrollmentCourse(request: EnrollmentCourseManualRequest) throws -> APIDataPublisher
    func createEnrollmentQBank(request: EnrollmentQBankManualRequest) throws -> APIDataPublisher
    func createEnrollmentEBook(request: EnrollmentEBookManualRequest) throws -> APIDataPublisher
    func createEnrollmentMassCourse(request: EnrollmentCourseGroupManualRequest) throws -> APIDataPublisher
}

class ProfileAPI: IProfileAPI {
    var networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    func getProfileDataRequest(request: GetProfileInfoRequest) throws -> APIDataPublisher {
        try sendAuthorizedAPICall(request: request)
    }
    
    func editProfileDataRequest(request: EditProfileRequest) throws -> APIDataPublisher {
        try sendAuthorizedFormAPICall(request: request)
    }
    
    func getTeamPermissions(request: TeamPermissionsRequest) throws -> APIDataPublisher {
        try sendTeamAuthorizedAPICall(request: request)
    }
    
    func getMemberList(request: MemberListRequest) throws -> APIDataPublisher {
        try sendTeamAuthorizedAPICall(request: request)
    }
    
    func getActivation(request: ActivationsRequest) throws -> APIDataPublisher {
        try sendTeamAuthorizedAPICall(request: request)
    }
    
    func acceptActivation(activationID: Int) throws -> APIDataPublisher {
        let request = AcceptActivationRequest(activationID: activationID)
        return try sendTeamAuthorizedAPICall(request: request)
    }
    
    func acceptAllActivation(activationID: [Int]) throws -> APIDataPublisher {
        let request = AcceptAllActivationRequest(activationID: activationID)
        return try sendTeamAuthorizedAPICall(request: request)
    }
    
    func rejectActivation(activationID: Int) throws -> APIDataPublisher {
        let request = RejectActivationRequest(activationID: activationID)
        return try sendTeamAuthorizedAPICall(request: request)
    }
    
    func searchStaff(request: SearchStaffRequest) throws -> APIDataPublisher {
        try sendTeamAuthorizedAPICall(request: request)
    }
    
    func createEnrollmentCourse(request: EnrollmentCourseManualRequest) throws -> APIDataPublisher {
        try sendTeamAuthorizedAPICall(request: request)
    }
    
    func createEnrollmentQBank(request: EnrollmentQBankManualRequest) throws -> APIDataPublisher {
        try sendTeamAuthorizedAPICall(request: request)
    }
    
    func createEnrollmentEBook(request: EnrollmentEBookManualRequest) throws -> APIDataPublisher {
        try sendTeamAuthorizedAPICall(request: request)
    }
    
    func createEnrollmentMassCourse(request: EnrollmentCourseGroupManualRequest) throws -> APIDataPublisher {
        try sendTeamAuthorizedAPICall(request: request)
    }
}
