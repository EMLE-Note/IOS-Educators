//
//  GetStudentsResponseDTO.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 19/08/2024.
//

import Foundation
import EMLECore

class GetStudentsResponseDTO: Codable {
    let enrollments: [EnrollmentStudentDTO]
    let pagination: PaginationResponseDTO
}
