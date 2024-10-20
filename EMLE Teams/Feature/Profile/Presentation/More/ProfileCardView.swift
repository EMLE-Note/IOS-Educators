//
//  ProfileCardView.swift
//  EMLE Learners
//
//  Created by Abdelrhman Sultan on 08/05/2024.
//

import SwiftUI
import EMLECore

struct ProfileCardView: View {
    
    var user: User
    
    var body: some View {
        HStack(spacing: 12) {
            
            image
            
            VStack(alignment: .leading, spacing: 2) {
                
                name
                
                if let _ = user.studyingField?.displayName {
                    specialize
                }
                
                if let _ = user.location?.name {
                    location
                }
            }
            
            Spacer()
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 16)
    }
    
    private var image: some View {
        CustomImageView(image: user.image, 
                        placeholder: .placeholder)
            .frame(width: 64, height: 64)
            .clipShape(Circle())
    }
    
    private var name: some View {
        Text(user.name)
            .customStyle(.headline, .onSurface)
    }
    
    private var job: some View {
        Text("Neurologist")
            .customStyle(.bodySmall, .subtitle)
    }
    
    private var dot: some View {
        Circle()
            .fill()
            .customBackground(.primary)
            .frame(width: 4, height: 4)
    }
    
    private var specialize: some View {
        Text(user.studyingField!.displayName)
            .customStyle(.bodySmall, .subtitle)
    }
    
    private var location: some View {
        Text(user.location!.name)
            .customStyle(.bodySmall, .subtitle)
    }
}

#Preview {
    ProfileCardView(user: .dummy)
}
