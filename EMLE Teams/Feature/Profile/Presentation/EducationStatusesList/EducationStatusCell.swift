//
//  EducationStatusCell.swift
//  EMLE Learners
//
//  Created by Abdelrhman Sultan on 14/05/2024.
//

import SwiftUI
import EMLECore

struct EducationStatusCell: View {
    
    var educationStatus: EducationStatus
    
    var selectAction: EducationStatusDelegate = nil
    
    var body: some View {
        Button {
            selectAction?(educationStatus)
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
            Text(educationStatus.displayName)
                .customStyle(.subheadline, .onSurface)
            
            Spacer()
        }
    }
}

#Preview {
    EducationStatusCell(educationStatus: .placeholder)
}
