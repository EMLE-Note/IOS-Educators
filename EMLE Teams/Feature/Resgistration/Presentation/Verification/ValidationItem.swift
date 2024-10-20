//
//  ValidationItem.swift
//  EMLE Learners
//
//  Created by Abdelrhman Sultan on 15/04/2024.
//

import SwiftUI
import EMLECore

struct ValidationItem: View {
    
    var value: String
    
    var isSelected: Bool = false
    
    var body: some View {
        Text(value)
            .customFont(size: 20, weight: ._600, lineHeight: 20)
            .customForeground(.onSurface)
            .frame(width: 40, height: 56)
            .withCardBorder(cornerRadius: 12,
                            borderColor: isSelected ? .primary : .primaryOpacity(opacity: 0.3))
    }
    
}

#Preview {
    HStack {
        ValidationItem(value: "1", isSelected: true)
    }
}
