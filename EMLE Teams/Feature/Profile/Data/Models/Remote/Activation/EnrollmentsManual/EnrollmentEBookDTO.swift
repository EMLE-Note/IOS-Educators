//
//  EnrollmentEBookDTO.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 17/10/2024.
//

import Foundation
import EMLECore

class EnrollmentEBookDTO: Codable, RequestDTO {
    var student_id: Int?
    var ebook_id: Int?
    var paid_amount: Int?
    var location_id: Int?
    var notes: String?
    var price: Int?
    
    init(student_id: Int? = nil, ebook_id: Int? = nil, paid_amount: Int? = nil, location_id: Int? = nil, notes: String? = nil, price: Int? = nil) {
        self.student_id = student_id
        self.ebook_id = ebook_id
        self.paid_amount = paid_amount
        self.location_id = location_id
        self.notes = notes
        self.price = price
    }
}
