//
//  EditSecurityDTO.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 26/08/2024.
//

import Foundation
import EMLECore

class EditSecurityDTO: Codable, RequestDTO {
    let finger_print_time: Int?
    let student_name_time: Int?
    let prevent_screen_record: Bool?
    let notification_security: Bool?
    let headphone_security: Bool?
    let national_id_security: Bool?
    let face_recognition_security: Bool?
    let signature: EditSignatureDTO?

    init(finger_print_time: Int?, student_name_time: Int?, prevent_screen_record: Bool?, notification_security: Bool?, headphone_security: Bool?, national_id_security: Bool?, face_recognition_security: Bool?, signature: EditSignatureDTO?) {
        self.finger_print_time = finger_print_time
        self.student_name_time = student_name_time
        self.prevent_screen_record = prevent_screen_record
        self.notification_security = notification_security
        self.headphone_security = headphone_security
        self.national_id_security = national_id_security
        self.face_recognition_security = face_recognition_security
        self.signature = signature
        
    }
    
    init(security: Security) {
        self.finger_print_time = security.fingerPrintTime
        self.student_name_time = security.studentNameTime
        self.prevent_screen_record = security.preventScreenRecord
        self.notification_security = security.notificationSecurity
        self.headphone_security = security.headphoneSecurity
        self.national_id_security = security.nationalIdSecurity
        self.face_recognition_security = security.faceRecognitionSecurity
        self.signature = security.signature != nil ? EditSignatureDTO(signature: security.signature!) : nil
    }
}
