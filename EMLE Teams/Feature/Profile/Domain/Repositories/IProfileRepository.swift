//
//  IProfileRepository.swift
//  EMLE Learners
//
//  Created by Abdelrhman Sultan on 20/05/2024.
//

import Foundation
import EMLECore

protocol IProfileRepository: RepositoryProtocol {
    func getProfileData() throws -> ProfileDataPublisher
    func editProfileData(editProfile: EditProfile) throws -> EditProfilePublisher
    func getTeamPermissionsData() throws -> TeamPermissionsPublisher
    func getMemberListData() throws -> MemberListPublisher
    func getActivationsData() throws -> ActivationPublisher
    func acceptActivationsData(activationID: Int) throws -> AcceptActivationPublisher
    func acceptAllActivationsData(activationID: [Int]) throws -> AcceptActivationPublisher
    func rejectActivationsData(activationID: Int) throws -> RejectActivationPublisher
    func searchStaff(parms: SearchStaffParameter) throws -> SearchStaffPublisher
    func createEnrollmentCourse(parms: EnrollmentCourse) throws -> EnrollmentManualPublisher
    func createEnrollmentQBank(parms: EnrollmentCourse) throws -> EnrollmentManualPublisher
    func createEnrollmentEBook(parms: EnrollmentCourse) throws -> EnrollmentManualPublisher
    func createEnrollmentMassCourse(parms: EnrollmentCourseParameter) throws -> EnrollmentManualPublisher
    func getInvitationsListData() throws -> InvitationListPublisher
    func invitationAction(invitationID: Int, params: InvitationActionParameters) throws -> InvitationActionPublisher
}
