//
//  APIEndPoint.swift
//  EMLE Teams
//
//  Created by Mustafa Merza on 7/14/24.
//

import Foundation
import EMLECore

extension APIEndPoint {
    
    //Global
    static let teamPermission = APIEndPoint("/globals/team-permissions")
    
    //Resgistration
    static let login = APIEndPoint("/team/login")
    static let register1 = APIEndPoint("/team/register-step1")
    static let register2 = APIEndPoint("/team/register-step2")
    static let register3 = APIEndPoint("/team/register-step3")
    static let register4 = APIEndPoint("/team/register-step4")
    static let forgetPassword1 = APIEndPoint("/team/forget-password")
    static let forgetPassword2 = APIEndPoint("/team/forget-password-step2")
    static let forgetPassword3 = APIEndPoint("/team/forget-password-step3")
    
    //profile
    static let getProfile = APIEndPoint("/team/profile")
    
    static let finance = APIEndPoint("/team/team/finance")
    static let getwayBillsPayment = APIEndPoint("/team/team/finance/bills/gateway-payment")
    static let balanceBillsPayment = APIEndPoint("team/team/finance/bills/balance-payment")
    static let getExternalWallet = APIEndPoint("/team/team/finance/external-wallet")
    static let getSecretary = APIEndPoint("/team/team/finance/external-wallet/transactions")
    static let getTransactionsRequests = APIEndPoint("/team/team/finance/external-wallet/transactions-requests")
    static let confirmTransactionRequest = APIEndPoint("/team/team/finance/external-wallet/transactions-requests/%d")
    static let getEnrollmentsCourses = APIEndPoint("/team/team/finance/enrollment-debits/courses")
    static let declineCourse = APIEndPoint("/team/team/finance/enrollment-debits/courses/%d")
    static let memberList = APIEndPoint("/team/team/members/list")
    static let getActivation = APIEndPoint("/team/team/enrollments/requests")
    static let acceptActivation = APIEndPoint("/team/team/enrollments/requests/%d")
    static let acceptAllActivation = APIEndPoint("/team/team/enrollments/requests/mass-accept")
    static let rejectActivation = APIEndPoint("/team/team/enrollments/requests/%d")
    static let searchStaff = APIEndPoint("/team/search-for-student-by-mobile")
    
    static let enrollmentCourse = APIEndPoint("/team/team/enrollments/manual/courses")
    static let enrollmentQBank = APIEndPoint("/team/team/enrollments/manual/qbanks")
    static let enrollmentEBook = APIEndPoint("/team/team/enrollments/manual/ebooks")
    static let enrollmentMass = APIEndPoint("/team/team/enrollments/manual/mass-courses")
    
    
    // team
    static let createTeam = APIEndPoint("/team/team/new")
    static let getMyTeams = APIEndPoint("/team/my-teams")
    static let teamInvitationsList = APIEndPoint("/team/invitations/list")
    static let teamInvitationsAction = APIEndPoint("/team/invitations/%d/take_action")

    static let getCourses = APIEndPoint("/team/team/courses")
    static let getContent = APIEndPoint("/team/team/courses/%d")
    static let getChilderFolder = APIEndPoint("/team/team/courses/course-folders/%d")
    static let updateFolder = APIEndPoint("/team/team/courses/course-folders/%d")
    static let deleteFolder = APIEndPoint("/team/team/courses/course-folders/%d")
    static let getStudents = APIEndPoint("/team/team/courses/%d/students")
    static let updateStudent = APIEndPoint("/team/team/courses/enrollments/%d")
    static let createCourse = APIEndPoint("/team/team/courses")
    static let updateCourse = APIEndPoint("/team/team/courses/%d")
    static let deleteCourse = APIEndPoint("/team/team/courses/%d")
    static let updateStatusStudent = APIEndPoint("/team/team/courses/%d/students/mass-update-status")
    static let createGroup = APIEndPoint("/team/team/courses/groups")
    static let deleteGroup = APIEndPoint("/team/team/groups/%d")
    
    static let createQBank = APIEndPoint("/team/team/qbanks")
    static let getQBank = APIEndPoint("/team/team/qbanks/%d")
    static let updateQBank = APIEndPoint("/team/team/qbanks/%d")
    
    static let uploadVideo = APIEndPoint("/team/team/courses/course-materials/videos")
    static let editMatrail = APIEndPoint("/team/team/courses/course-materials/%d")
    static let copyMatrail = APIEndPoint("/team/team/courses/course-materials/%d/copy")
    
}
