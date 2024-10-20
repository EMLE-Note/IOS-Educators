//
//  GraduationYearsList.swift
//  EMLE Learners
//
//  Created by Abdelrhman Sultan on 14/05/2024.
//

import SwiftUI
import EMLECore

struct GraduationYearsList: View {
    var years: [GraduationYear]
    var selectAction: GraduationYearDelegate = nil
    
    var body: some View {
        ScrollView {
            list
        }
        .frame(height: 300)
        .padding(.horizontal, 16)
        .padding(.vertical, 20)
        .customCornerRadii(12, corners: [.topLeft, .topRight])
        .ignoresSafeArea()
        .customBackground(.container)
        .handleLayoutChanges()
    }
    
    private var list: some View {
        VStack(spacing: 16) {
            ForEach(years) { year in
                GraduationYearCell(year: year, selectAction: selectAction)
            }
        }
    }
}

#Preview {
    GraduationYearsList(years: [GraduationYear.placeholder])
}
