//
//  EditSignatureDTO.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 26/08/2024.
//

import Foundation

class EditSignatureDTO: Codable {
    let font_size: Int?
    let font_weight: Int?
    
    init(font_size: Int?, font_weight: Int?) {
        self.font_size = font_size
        self.font_weight = font_weight
    }
    
    init(signature: Signature) {
        self.font_size = signature.fontSize
        self.font_weight = signature.fontWeight
    }
}

