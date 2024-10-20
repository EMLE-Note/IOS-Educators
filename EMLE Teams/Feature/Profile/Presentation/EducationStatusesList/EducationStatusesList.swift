//
//  EducationStatusesList.swift
//  EMLE Learners
//
//  Created by Abdelrhman Sultan on 14/05/2024.
//

import SwiftUI
import EMLECore

struct EducationStatusesList: View {
    
    var educationStatuses: [EducationStatus]
    
    var selectAction: EducationStatusDelegate = nil
    
    var body: some View {
        ScrollView {
            list
        }
        .frame(height: 100)
        .padding(.vertical, 20)
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 16)
        .customCornerRadii(12, corners: [.topLeft, .topRight])
        .ignoresSafeArea()
        .customBackground(.container)
        .handleLayoutChanges()
    }
    
    private var list: some View {
        VStack(spacing: 16) {
            ForEach(educationStatuses) { educationStatus in
                EducationStatusCell(educationStatus: educationStatus, selectAction: selectAction)
            }
        }
    }
}

#Preview {
    EducationStatusesList(educationStatuses: [EducationStatus.placeholder])
}
