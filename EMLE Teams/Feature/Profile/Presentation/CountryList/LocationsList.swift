//
//  LocationsList.swift
//  EMLE Learners
//
//  Created by Abdelrhman Sultan on 14/05/2024.
//

import SwiftUI
import EMLECore

struct LocationsList: View {
    
    var locations: [Location]
    
    var selectAction: LocationDelegate = nil
    
    var body: some View {
        ScrollView {
            list
        }
        .frame(height: 200)
        .padding(.horizontal, 16)
        .padding(.vertical, 20)
        .customCornerRadii(12, corners: [.topLeft, .topRight])
        .ignoresSafeArea()
        .customBackground(.container)
        .handleLayoutChanges()
    }
    
    private var list: some View {
        VStack(spacing: 16) {
            ForEach(locations) { location in
                LocationCell(location: location, selectAction: selectAction)
            }
        }
    }
}

#Preview {
    LocationsList(locations: [.placeholder])
}
