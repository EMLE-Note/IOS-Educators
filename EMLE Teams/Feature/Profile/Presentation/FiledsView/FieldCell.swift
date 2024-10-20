//
//  FieldCell.swift
//  EMLE Learners
//
//  Created by Abdelrhman Sultan on 13/05/2024.
//

import SwiftUI
import EMLECore

struct FieldCell: View {
    
    var field: StudyingField
    
    var selectAction: StudyingFieldDelegate = nil
    
    var body: some View {
        Button {
            selectAction?(field)
        } label: {
            cell
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 6)
        .customCornerRadius(8)
        .customBackground(.container)
    }
    
    private var cell: some View {
        HStack {
            Text(field.displayName)
                .customStyle(.subheadline, .onSurface)
            
            Spacer()
        }
    }
}

#Preview {
    FieldCell(field: .placeholder)
}
