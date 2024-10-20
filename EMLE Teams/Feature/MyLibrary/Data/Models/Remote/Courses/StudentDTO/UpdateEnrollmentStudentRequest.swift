//
//  UpdateEnrollmentStudentRequest.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 19/08/2024.
//

import Foundation
import EMLECore
import Alamofire

class UpdateEnrollmentStudentRequest: CustomRequest {

    var endPoint: APIEndPoint { .updateStudent }
    var method: RequestMethod { .post }
    var url: String { String(format: MainCloudConfig.apiUrl + endPoint.value, enrollmentId) }
    
    var dto: RequestDTO? { _dto }

    let _dto: UpdateEnrollmentStudentDTO
    
    var enrollmentId: Int

    init(enrollmentId: Int,
         status: Int? = nil,
         security: Security?,
         locationId: Int? = nil,
         expireAt: String? = nil) {

        self.enrollmentId = enrollmentId
        let editSecurityDTO = EditSecurityDTO(
            finger_print_time: security?.fingerPrintTime,
            student_name_time: security?.studentNameTime,
            prevent_screen_record: security?.preventScreenRecord,
            notification_security: security?.notificationSecurity,
            headphone_security: security?.headphoneSecurity,
            national_id_security: security?.nationalIdSecurity,
            face_recognition_security: security?.faceRecognitionSecurity,
            signature: security?.signature != nil ? EditSignatureDTO(
                font_size: security?.signature?.fontSize,
                font_weight: security?.signature?.fontWeight
            ) : nil
        )
        self._dto = UpdateEnrollmentStudentDTO(status: status, security: editSecurityDTO, locationId: locationId, expireAt: expireAt)
    }
}
