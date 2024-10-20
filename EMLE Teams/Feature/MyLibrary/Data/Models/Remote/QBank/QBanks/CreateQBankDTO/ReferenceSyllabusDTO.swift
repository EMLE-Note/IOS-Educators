//
//  ReferenceSyllabusDTO.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 16/09/2024.
//

import Foundation

class ReferenceSyllabusDTO: Codable {
    let id: Int
    let name, overview: String
    let exam_questions_percentage: Int
}
