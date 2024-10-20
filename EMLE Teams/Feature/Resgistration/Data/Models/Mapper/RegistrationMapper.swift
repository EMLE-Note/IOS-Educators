//
//  RegistrationMapper.swift
//  EMLE Learners
//
//  Created by Abdelrhman Sultan on 04/04/2024.
//

import Foundation
import EMLECore

extension LoginResponseDTO {
    
    func toDomain() throws -> User {
        
        guard let status = RegisterStatus(rawValue: register_status_numeric ?? 4) else {
            throw UseCaseError.decodingError(message: "Can't convert register status.")
        }
        
        let token = Token(token: api_token ?? "")
        
        var profileImage: ImageUrl? = nil
        
        if let image {
            profileImage = ImageUrl(urlString: image)
        }
        
        return User(id: id,
                    token: token,
                    name: name ?? "",
                    status: status,
                    isSignedIn: true,
                    image: profileImage,
                    studyingField: field?.toDomain(parentId: nil),
                    location: location?.toDomain(),
                    type: type?.toDomain())
    }
}

extension Login {
    func toRequest() -> LoginRequest {
        return LoginRequest(mobile_code: mobileCode,
                            mobile: mobile,
                            password: password,
                            fb_token: FCMToken)
    }
    
}

extension Register1 {
    func toRequest() -> Register1Request {
        Register1Request(mobile_code: mobileCode, mobile: mobile, verification_method: method.rawValue)
    }
}

extension Register1ResponseDTO {
    func toDomain() -> VerificationURL {
        VerificationURL(url: telegram_url)
    }
}

extension Register2 {
    func toRequest() -> Register2Request {
        Register2Request(mobile_code: mobileCode, mobile: mobile, otp_code: OTP)
    }
}

extension Register3 {
    func toRequest() -> Register3Request {
        Register3Request(mobile_code: mobileCode,
                         mobile: mobile,
                         otp_code: OTP,
                         password: password,
                         password_confirmation: confirmPassword)
    }
}

extension Register4 {
    func toRequest() -> Register4Request {
        Register4Request(name: name, field_id: fieldId, type_id: typeId, image: image, job_title: jobTitle, overview: overview)
    }
}

extension ForgetPassword1 {
    func toRequest() -> ForgetPassword1Request {
        ForgetPassword1Request(mobile_code: mobileCode, mobile: mobile, verification_method: method.rawValue)
    }
}

extension ForgetPassword1ResponseDTO {
    func toDomain() -> VerificationURL {
        VerificationURL(url: telegram_url)
    }
}

extension ForgetPassword2 {
    func toRequest() -> ForgetPassword2Request {
        ForgetPassword2Request(mobile_code: mobileCode, mobile: mobile, otp_code: OTP)
    }
}

extension ForgetPassword3 {
    func toRequest() -> ForgetPassword3Request {
        ForgetPassword3Request(mobile_code: mobileCode, mobile: mobile, otp_code: OTP, new_password: password, new_password_confirmation: confirmPassword)
    }
}
