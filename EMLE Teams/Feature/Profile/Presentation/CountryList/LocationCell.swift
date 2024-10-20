//
//  LocationCell.swift
//  EMLE Learners
//
//  Created by Abdelrhman Sultan on 14/05/2024.
//

import SwiftUI
import EMLECore

struct LocationCell: View {
    
    var location: Location
    
    var selectAction: LocationDelegate = nil
    
    var body: some View {
        Button {
            selectAction?(location)
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
            Text(location.name)
                .customStyle(.subheadline, .onSurface)
            
            Spacer()
        }
    }
}

#Preview {
    LocationCell(location: .placeholder)
}
