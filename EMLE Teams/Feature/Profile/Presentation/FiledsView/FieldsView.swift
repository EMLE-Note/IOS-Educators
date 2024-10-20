//
//  FieldsView.swift
//  EMLE Learners
//
//  Created by Abdelrhman Sultan on 12/05/2024.
//

import SwiftUI
import EMLECore

struct FieldsView: View {
    
    var fields: [StudyingField]
    
    var selectAction: StudyingFieldDelegate = nil
    
    var parentField: StudyingField?
    
    var backAction: EmptyAction = nil
    
    @Binding var isPresented: Bool
    
    var isDoneButtonDisabled: Bool
    
    var body: some View {
        VStack(spacing: 12) {
            
            fieldTitle
                .unredacted()
            
            fieldsList
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 20)
        .customBackground(.container)
        .customCornerRadii(12, corners: [.topLeft, .topRight])
        .ignoresSafeArea()
        .handleLayoutChanges()
    }
    
    private var fieldTitle: some View {
        HStack {
            
            
            if parentField != nil {
                Button(action: {
                    backAction?()
                }, label: {
                    
                    HStack(spacing: 8) {
                        
                        Image.chevronBackward
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 16, height: 9)
                            .customForeground(.subtitle)
                        
                        Text(parentField!.displayName)
                            .customStyle(.headline, .onSurface)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                })
            }
            
            Spacer()
            
            done
        }
    }
    
    private var done: some View {
        Button {
            isPresented = false
        } label: {
            Text(BasicStrings.done.localized)
                .customStyle(.headline, isDoneButtonDisabled ? .neutral : .primary)
        }
        .disabled(isDoneButtonDisabled)
    }
    
    private var fieldsList: some View {
        ScrollView(showsIndicators: false) {
            FieldsListView(fields: fields,
                           selectAction: selectAction)
        }
    }
}

#Preview {
    FieldsView(fields: .placeholder,
               parentField: .placeholder,
               isPresented: .constant(true),
               isDoneButtonDisabled: false)
}
