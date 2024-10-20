//
//  RegistrationAPI.swift
//  EMLE Learners
//
//  Created by Abdelrhman Sultan on 04/04/2024.
//

import Foundation
import EMLECore
import Combine

protocol IRegistrationAPI: APIProtocol {
    func sendLoginRequest(request: LoginRequest) throws -> APIDataPublisher
    func sendRegister1Request(request: Register1Request) throws -> APIDataPublisher
    func sendRegister2Request(request: Register2Request) throws -> APIDataPublisher
    func sendRegister3Request(request: Register3Request) throws -> APIDataPublisher
    func sendRegister4Request(request: Register4Request) throws -> APIDataPublisher
    func sendForgetPassword1Request(request: ForgetPassword1Request) throws -> APIDataPublisher
    func sendForgetPassword2Request(request: ForgetPassword2Request) throws -> APIDataPublisher
    func sendForgetPassword3Request(request: ForgetPassword3Request) throws -> APIDataPublisher
}

class RegistrationAPI: IRegistrationAPI {
    
    var networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    func sendLoginRequest(request: LoginRequest) throws -> APIDataPublisher {
        try sendAPICall(request: request)
    }
    
    func sendRegister1Request(request: Register1Request) throws -> APIDataPublisher {
        try sendAPICall(request: request)
    }
    
    func sendRegister2Request(request: Register2Request) throws -> APIDataPublisher {
        try sendAPICall(request: request)
    }
    
    func sendRegister3Request(request: Register3Request) throws -> APIDataPublisher {
        try sendAPICall(request: request)
    }
    
    func sendRegister4Request(request: Register4Request) throws -> APIDataPublisher {
        try sendAuthorizedFormAPICall(request: request)
    }
    
    func sendForgetPassword1Request(request: ForgetPassword1Request) throws -> APIDataPublisher {
        try sendAPICall(request: request)
    }
    
    func sendForgetPassword2Request(request: ForgetPassword2Request) throws -> APIDataPublisher {
        try sendAPICall(request: request)
    }
    
    func sendForgetPassword3Request(request: ForgetPassword3Request) throws -> APIDataPublisher {
        try sendAPICall(request: request)
    }
}
