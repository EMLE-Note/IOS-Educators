//
//  Signature.swift
//  EMLE Teams
//
//  Created by iOSAYed on 16/08/2024.
//

import Foundation

struct Signature: Hashable {
    let fontSize, fontWeight: Int?
}

extension Signature {
    static let placeholder = Signature(fontSize: 0, fontWeight: 0)
}
