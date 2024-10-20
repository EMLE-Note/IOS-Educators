//
//  IRegistrationRepository.swift
//  EMLE Learners
//
//  Created by Abdelrhman Sultan on 04/04/2024.
//

import Foundation
import EMLECore

protocol IRegistrationRepository: RepositoryProtocol {
    func login(params: Login) throws -> LoginPublisher
    
    func register1(params: Register1) throws -> Register1Publisher
    func register2(params: Register2) throws -> Register2Publisher
    func register3(params: Register3) throws -> Register3Publisher
    func register4(params: Register4) throws -> Register4Publisher
    
    func forgetPassword1(params: ForgetPassword1) throws -> forgetPassword1Publisher
    func forgetPassword2(params: ForgetPassword2) throws -> DomainBoolPublisher
    func forgetPassword3(params: ForgetPassword3) throws -> DomainBoolPublisher
}
