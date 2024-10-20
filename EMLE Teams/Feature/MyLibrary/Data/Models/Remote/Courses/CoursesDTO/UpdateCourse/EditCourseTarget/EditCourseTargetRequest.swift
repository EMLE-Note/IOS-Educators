//
//  EditCourseTargetRequest.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 15/09/2024.
//

import Foundation
import EMLECore
import Alamofire

class EditCourseTargetRequest: CustomRequest {
    var endPoint: APIEndPoint { .updateCourse }
    var method: RequestMethod { .post }
    var url: String { String(format: MainCloudConfig.apiUrl + endPoint.value, courseId) }
    
    var dto: RequestDTO? { _dto }

    private let _dto: EditCourseTargetDTO?
    var courseId: Int

    init(courseId: Int, targets: [Target]?, displayPrice: Int?, displayStudentsCount: Int?) {
        self.courseId = courseId

        if let targets = targets, !targets.isEmpty {
            self._dto = EditCourseTargetDTO(targets: targets.compactMap { target in
                EditTargetDTO(
                    id: target.targetId,
                    name: target.name,
                    institution_id: target.institution.institutionId,
                    type_id: target.type.educationStatusId,
                    field_id: target.field.fieldId
                )
            }, display_price: displayPrice, display_students_count: displayStudentsCount)
        } else {
            self._dto = EditCourseTargetDTO(targets: [], display_price: displayPrice, display_students_count: displayStudentsCount)
        }
    }
}
