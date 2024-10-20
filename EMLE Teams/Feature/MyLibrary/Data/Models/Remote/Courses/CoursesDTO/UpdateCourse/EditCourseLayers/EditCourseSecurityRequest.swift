//
//  EditCourseSecurityRequest.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 26/08/2024.
//

import Foundation
import EMLECore
import Alamofire

class EditCourseSecurityRequest: CustomRequest {
    var endPoint: APIEndPoint { .updateCourse }
    var method: RequestMethod { .post }
    var url: String { String(format: MainCloudConfig.apiUrl + endPoint.value, courseId) }
    
    var dto: RequestDTO? { _dto }

    private let _dto: EditCourseSecurityDTO
    var courseId: Int

    init(courseId: Int, security: Security?) {
        self.courseId = courseId
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
        self._dto = EditCourseSecurityDTO(security: editSecurityDTO)
    }
}

