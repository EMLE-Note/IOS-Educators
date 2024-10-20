//
//  SecurityRequestFromData.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 19/09/2024.
//

import Foundation
import EMLECore

class SecurityRequestFromData: Codable {
    let signature: SignatureRequestFromData?
    let finger_print_time, student_name_time: Int?
    let prevent_screen_record, face_recognition_time, notification_security, headphone_security: Bool?

    // Initializer
    init(signature: SignatureRequestFromData?,
         finger_print_time: Int? ,
         face_recognition_time: Bool? ,
         student_name_time: Int?,
         prevent_screen_record: Bool?,
         notification_security: Bool?,
         headphone_security: Bool?) {
        
        self.signature = signature
        self.finger_print_time = finger_print_time
        self.face_recognition_time = face_recognition_time
        self.student_name_time = student_name_time
        self.prevent_screen_record = prevent_screen_record
        self.notification_security = notification_security
        self.headphone_security = headphone_security
    }

    // Form data generation
    var formData: FormData {
        var data: FormData = [:]

        if let signature = signature {
            data.merge(signature.formData) { (_, new) in new }
        }
        if let finger_print_time = finger_print_time {
            data["security[finger_print_time]"] = finger_print_time
        }
        if let face_recognition_time = face_recognition_time {
            data["security[face_recognition_time]"] = face_recognition_time
        }
        if let student_name_time = student_name_time {
            data["security[student_name_time]"] = student_name_time
        }
        if let prevent_screen_record = prevent_screen_record {
            data["security[prevent_screen_record]"] = prevent_screen_record
        }
        if let notification_security = notification_security {
            data["security[notification_security]"] = notification_security
        }
        if let headphone_security = headphone_security {
            data["security[headphone_security]"] = headphone_security
        }

        return data
    }
}
