//
//  UpdateCourseParameter.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 21/08/2024.
//

import Foundation
import EMLECore
import UIKit

extension UpdateCourseParameter {
    func toRequest() -> EditCourseSettingRequest {
        return EditCourseSettingRequest(courseId: courseId, data: data.toRequestDTO())
    }
}

extension CreateCourseRequestFrom {
    func toRequest() -> CreateCourseRequest {
        return CreateCourseRequest(data: toFromData())
    }
}

extension UpdateCourse {
    func toRequestDTO() -> UpdateCourseDTO {
        return UpdateCourseDTO(status: status, name: name, image: image, overview: overview, duration: duration, publishAt: publishAt, expireAt: expireAt, isVisible: isVisible, isAllowedOffline: isAllowedOffline, price: price, groups: groups)
    }
}

extension [Target] {
    func toRequest() -> [TargetDTO] {
        map { $0.toRequestDTO() }
    }
}

extension Target {
    func toRequestDTO() -> TargetDTO {
        return TargetDTO(id: targetId, name: name, field: field.toRequestDTO(), institution: institution.toRequestDTO(), type: type.toRequestDTO())
    }
}

extension StudyingField {
    func toRequestDTO() -> FieldResponseDTO {
        return FieldResponseDTO(id: fieldId, name: name, type_id: typeId)
    }
}

extension Institution {
    func toRequestDTO() -> InstitutionResponseDTO {
        return InstitutionResponseDTO(id: institutionId, name: name)
    }
}


extension Security {
    func toRequestDTO() -> SecurityDTO {
        return SecurityDTO(
            finger_print_time: fingerPrintTime,
            student_name_time: studentNameTime,
            prevent_screen_record: preventScreenRecord,
            notification_security: notificationSecurity,
            headphone_security: headphoneSecurity,
            national_id_security: nationalIdSecurity,
            face_recognition_security: faceRecognitionSecurity,
            signature: signature?.toRequestDTO()
        )
    }
}

extension Signature {
    func toRequestDTO() -> SignatureDTO {
        return SignatureDTO(font_size: fontSize, font_weight: fontWeight)
    }
}

// Update the Extension
extension UpdateCourseFormDataRequest {
    func toRequestDTO() -> UpdateCourseFormDataRequestDTO {
        return UpdateCourseFormDataRequestDTO(
            status: status,
            name: name,
            image: image,
            overview: overview,
            duration: duration,
            expire_at: expireAt,
            publish_at: publishAt,
            is_visible: isVisible,
            is_allowed_offline: isAllowedOffline,
            price: price,
            _method: method,
            groups: groups
        )
    }
}

extension CreateCourseRequestFrom {
    func toFromData() -> CreateCourseRequestFormData {
        return CreateCourseRequestFormData(uuid: uuid, name: name, price: price, duration: duration, image: image, publish_at: publishAt, is_visible: isVisible, is_allowed_offline: isAllowedOffline, overview: overview, expire_at: expireAt, security: security?.toFromData(), targets: targets?.toFromData(), groups: groups)
    }
}

extension Security {
    func toFromData() -> SecurityRequestFromData {
        return SecurityRequestFromData(signature: signature?.toFromData(), finger_print_time: fingerPrintTime, face_recognition_time: faceRecognitionSecurity, student_name_time: studentNameTime, prevent_screen_record: preventScreenRecord, notification_security: notificationSecurity, headphone_security: headphoneSecurity)
    }
}

extension Signature {
    func toFromData() -> SignatureRequestFromData {
        return SignatureRequestFromData(font_size: fontSize, font_weight: fontWeight)
    }
}

extension [TargetRequestFrom] {
    func toFromData() -> [TargetRequestFromData] {
        map { $0.toFromData() }
    }
}

extension TargetRequestFrom {
    func toFromData() -> TargetRequestFromData {
        return TargetRequestFromData(name: name, institution_id: institution_id, type_id: type_id, field_id: field_id, students_count: students_count)
    }
}

extension EditCourseSecurityParameter {
    func toRequest() -> EditCourseSecurityRequest {
        return EditCourseSecurityRequest(courseId: courseId, security: security)
    }
}

extension EditCourseTargetParameter {
    func toRequest() -> EditCourseTargetRequest {
        return EditCourseTargetRequest(courseId: courseId, targets: targets, displayPrice: displayPrice, displayStudentsCount: displayStudentsCount)
    }
}

extension Security {
    func toRequestDTO() -> EditSecurityDTO {
        return EditSecurityDTO(finger_print_time: fingerPrintTime, student_name_time: studentNameTime, prevent_screen_record: preventScreenRecord, notification_security: notificationSecurity, headphone_security: headphoneSecurity, national_id_security: nationalIdSecurity, face_recognition_security: faceRecognitionSecurity, signature: signature?.toRequestDTO())
    }
}

extension Signature {
    func toRequestDTO() -> EditSignatureDTO {
        EditSignatureDTO(font_size: fontSize, font_weight: fontWeight)
    }
}

extension EducationStatus {
    func toRequestDTO() -> TypeResponseDTO {
        return TypeResponseDTO(id: educationStatusId, name: name)
    }
}

