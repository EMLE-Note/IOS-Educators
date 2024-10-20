//
//  SignatureDTO.swift
//  EMLE Teams
//
//  Created by iOSAYed on 16/08/2024.
//

import Foundation

class SignatureDTO: Codable {
    let font_size: Int?
    let font_weight: Int?
    
    init(font_size: Int?, font_weight: Int?) {
        self.font_size = font_size
        self.font_weight = font_weight
    }
}
