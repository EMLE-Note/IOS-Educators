//
//  RegistrationRepository.swift
//  EMLE Learners
//
//  Created by Abdelrhman Sultan on 04/04/2024.
//

import Foundation
import EMLECore
import Combine

typealias LoginPublisher = DomainPublisher<User>

typealias Register1Publisher = DomainPublisher<VerificationURL>
typealias Register2Publisher = DomainPublisher<User>
typealias Register3Publisher = DomainPublisher<User>
typealias Register4Publisher = DomainPublisher<User>

typealias forgetPassword1Publisher = DomainPublisher<VerificationURL>

class RegistrationRepository: IRegistrationRepository {
    
    let registrationDataSource: IRegistrationDataSource
    
    @Inject var changeUserUseCase: ChangeUserUseCase<User>
    
    init(registrationDataSource: IRegistrationDataSource) {
        self.registrationDataSource = registrationDataSource
    }
    
    func login(params: Login) throws -> LoginPublisher {
        try registrationDataSource.login(params: params)
            .tryMap { try self.mapSignInResponseDTO(response: $0) }
            .mapError()
            .eraseToAnyPublisher()
    }
    
    func register1(params: Register1) throws -> Register1Publisher {
        try registrationDataSource.register1(params: params)
            .map { $0.toDomainWrapper(with: $0.data?.toDomain()) }
            .mapError()
            .eraseToAnyPublisher()
    }
    
    func register2(params: Register2) throws -> Register2Publisher {
        try registrationDataSource.register2(params: params)
            .tryMap { $0.toDomainWrapper(with: try $0.data?.toDomain()) }
            .mapError()
            .eraseToAnyPublisher()
    }
    
    func register3(params: Register3) throws -> Register3Publisher {
        try registrationDataSource.register3(params: params)
            .tryMap { try self.mapRegister3ResponseDTO(response: $0) }
            .mapError()
            .eraseToAnyPublisher()
    }
    
    func register4(params: Register4) throws -> Register4Publisher {
        try registrationDataSource.register4(params: params)
            .tryMap { try $0.toDomainWrapper(with: $0.data?.toDomain()) }
            .mapError()
            .eraseToAnyPublisher()
    }
    
    func forgetPassword1(params: ForgetPassword1) throws -> forgetPassword1Publisher {
        try registrationDataSource.forgetPassword1(params: params)
            .map { $0.toDomainWrapper(with: $0.data?.toDomain()) }
            .mapError()
            .eraseToAnyPublisher()
    }
    
    func forgetPassword2(params: ForgetPassword2) throws -> DomainBoolPublisher {
        try registrationDataSource.forgetPassword2(params: params)
            .map { $0.toDomainWrapper(with: true) }
            .mapError()
            .eraseToAnyPublisher()
    }
    
    func forgetPassword3(params: ForgetPassword3) throws -> DomainBoolPublisher {
        try registrationDataSource.forgetPassword3(params: params)
            .map { $0.toDomainWrapper(with: true) }
            .mapError()
            .eraseToAnyPublisher()
    }
}

extension RegistrationRepository {
    private func mapSignInResponseDTO(response: ResponseDTO<LoginResponseDTO>) throws -> DomainWrapper<User> {
        
        let user = try response.data?.toDomain()
        
        if response.isSuccess, let user {
            
            if user.status == .finished {
                
                changeUserUseCase.execute(with: user)
                
            } else if user.status == .notCompleted {
                
                @Provide var token = user.token
            }
        }
        
        return response.toDomainWrapper(with: user)
    }
    
    private func mapRegister3ResponseDTO(response: ResponseDTO<Register3ResponseDTO>) throws -> DomainWrapper<User> {
        
        let user = try response.data?.toDomain()
        
        if response.isSuccess, let user {
            
            @Provide var token = user.token
        }
        
        return response.toDomainWrapper(with: user)
    }
}
