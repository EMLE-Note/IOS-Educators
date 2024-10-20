//
//  ExternallWalletMapper.swift
//  EMLE Teams
//
//  Created by iOSAYed on 20/07/2024.
//

import EMLECore
import Foundation

extension GetExternallWalletResponseDTO {
    func toDomain() throws -> ExternalWalletResponseDomain {
        let content = try data.toExternalWalletDomain()
             
             return ExternalWalletResponseDomain(
                 externalWallets: content,
                 pagination: pagination.toDomain(content: content),
                 externalWalletSum: external_wallet_sum,
                 transactionRequestCount: transaction_request_count
             )
         }
    }


extension ExternallWalletResponseDTO {
    func toDomain() -> ExternalWallet {
        return ExternalWallet(externalWalletId: id, contentType: content_type, enrollment: enrollment.toDomain(), receivable: receivable.toDomain(), amount: amount, createdAt: created_at)
    }
}

extension [ExternallWalletResponseDTO] {
    func toExternalWalletDomain() throws -> [ExternalWallet] {
        try map { try $0.toDomain() }
    }
}

extension EnrollmentDTO {
    func toDomain() -> Enrollment {
        return Enrollment(enrollmentId: id, status: status, type: type, price: price, remained: remained, content: content.toDomain(), student: student.toDomain(), expireAt: expire_at, createdAt: created_at)
    }
}

extension EnrollmentContentDTO {
    func toDomain() -> EnrollmentContent {
        var imageUrl: ImageUrl? = nil
        var imageConversionsUrl: ImageUrl? = nil

        if let image, let image_conversions {
            imageUrl = ImageUrl(urlString: image)
            imageConversionsUrl = ImageUrl(urlString: image_conversions)
        }
        return EnrollmentContent(id: id, name: name, image: imageUrl, price: price, imageConversions: imageConversionsUrl)
    }
}

extension StudentDTO {
    func toDomain() -> Student {
        var imageUrl: ImageUrl? = nil

        if let image {
            imageUrl = ImageUrl(urlString: image)
        }
        return Student(id: id, name: name, mobile: mobile, image: imageUrl)
    }
}

extension SecretaryDTO {
    func toDomain() -> Secretary {
        var imageUrl: ImageUrl? = nil

        if let image {
            imageUrl = ImageUrl(urlString: image)
        }
        return Secretary(SecretaryId: id, name: name, status: status, isInstructor: is_instructor, role: role, image: imageUrl, balance: balance)
    }
}


extension TransactionsContentFilter {
    func toRequestDTO() -> GetExternalWalletFilterRequestDTO {
        GetExternalWalletFilterRequestDTO(enrollmentType: enrollmentType, contentType: contentType, amount: amount, search: search,teamStaffId: teamStaffId, sort: sort)
    }
}

extension GetExternalWallet {
    func toRequest() -> GetExternalWalletRequest {
        GetExternalWalletRequest(filters: filters.toRequestDTO())
    }
}
