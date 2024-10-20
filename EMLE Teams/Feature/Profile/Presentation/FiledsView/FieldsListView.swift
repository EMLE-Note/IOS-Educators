//
//  FieldsListView.swift
//  EMLE Learners
//
//  Created by Abdelrhman Sultan on 13/05/2024.
//

import SwiftUI
import EMLECore

struct FieldsListView: View {
    
    var fields: [StudyingField]
    
    var selectAction: StudyingFieldDelegate = nil
    
    var body: some View {
        list
    }
    
    private var list: some View {
        VStack(spacing: 16) {
            ForEach(fields) { field in
                
                FieldCell(field: field,
                                 selectAction: selectAction)
            }
        }
    }
}

#Preview {
    FieldsListView(fields: .placeholder)
}
