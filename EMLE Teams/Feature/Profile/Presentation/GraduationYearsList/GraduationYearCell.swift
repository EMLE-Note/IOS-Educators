//
//  GraduationYearCell.swift
//  EMLE Learners
//
//  Created by Abdelrhman Sultan on 14/05/2024.
//

import SwiftUI
import EMLECore

struct GraduationYearCell: View {
    var year: GraduationYear
    var selectAction: GraduationYearDelegate = nil
    
    var body: some View {
        Button {
            selectAction?(year)
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
            Text(year.displayName)
                .customStyle(.subheadline, .onSurface)
            
            Spacer()
        }
    }
}

#Preview {
    GraduationYearCell(year: .placeholder)
}
