//
//  RegistrationDataSource.swift
//  EMLE Learners
//
//  Created by Abdelrhman Sultan on 04/04/2024.
//

import EMLECore

typealias LoginResponsePublisher = ResponsePublisher<LoginResponseDTO>

typealias Register1ResponsePublisher = ResponsePublisher<Register1ResponseDTO>
typealias Register2ResponsePublisher = ResponsePublisher<Register2ResponseDTO>
typealias Register3ResponsePublisher = ResponsePublisher<Register3ResponseDTO>
typealias Register4ResponsePublisher = ResponsePublisher<Register4ResponseDTO>

typealias ForgetPassword1ResponsePublisher = ResponsePublisher<ForgetPassword1ResponseDTO>
typealias ForgetPassword2ResponsePublisher = ResponsePublisher<ForgetPassword2ResponseDTO>
typealias ForgetPassword3ResponsePublisher = ResponsePublisher<ForgetPassword3ResponseDTO>

protocol IRegistrationDataSource: RemoteDataSourceProtocol {
    func login(params: Login) throws -> LoginResponsePublisher
    
    func register1(params: Register1) throws -> Register1ResponsePublisher
    func register2(params: Register2) throws -> Register2ResponsePublisher
    func register3(params: Register3) throws -> Register3ResponsePublisher
    func register4(params: Register4) throws -> Register4ResponsePublisher
    
    func forgetPassword1(params: ForgetPassword1) throws -> ForgetPassword1ResponsePublisher
    func forgetPassword2(params: ForgetPassword2) throws -> ForgetPassword2ResponsePublisher
    func forgetPassword3(params: ForgetPassword3) throws -> ForgetPassword3ResponsePublisher
}

class RegistrationDataSource: IRegistrationDataSource {
    
    let api: IRegistrationAPI
    
    init(api: IRegistrationAPI) {
        self.api = api
    }
    
    func login(params: Login) throws -> LoginResponsePublisher {
        try api.sendLoginRequest(request: params.toRequest())
            .toResponsePublisher()
    }
    
    func register1(params: Register1) throws -> Register1ResponsePublisher {
        try api.sendRegister1Request(request: params.toRequest())
            .toResponsePublisher()
    }
    
    func register2(params: Register2) throws -> Register2ResponsePublisher {
        try api.sendRegister2Request(request: params.toRequest())
            .toResponsePublisher()
    }
    
    func register3(params: Register3) throws -> Register3ResponsePublisher {
        try api.sendRegister3Request(request: params.toRequest())
            .toResponsePublisher()
    }
    
    func register4(params: Register4) throws -> Register4ResponsePublisher {
        try api.sendRegister4Request(request: params.toRequest())
            .toResponsePublisher()
    }
    
    func forgetPassword1(params: ForgetPassword1) throws -> ForgetPassword1ResponsePublisher {
        try api.sendForgetPassword1Request(request: params.toRequest())
            .toResponsePublisher()
    }
    
    func forgetPassword2(params: ForgetPassword2) throws -> ForgetPassword2ResponsePublisher {
        try api.sendForgetPassword2Request(request: params.toRequest())
            .toResponsePublisher()
    }
    
    func forgetPassword3(params: ForgetPassword3) throws -> ForgetPassword3ResponsePublisher {
        try api.sendForgetPassword3Request(request: params.toRequest())
            .toResponsePublisher()
    }
}
