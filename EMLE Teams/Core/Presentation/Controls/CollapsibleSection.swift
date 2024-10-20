//
//  CollapsibleSection.swift
//  EMLE Teams
//
//  Created by iOSAYed on 04/09/2024.
//

import Foundation
import SwiftUI
import EMLECore

struct CollapsibleSection<Content: View>: View {
    let title: String
    var isActive: Bool
    var toggle: () -> Void
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        VStack(alignment: .leading, spacing: .sm) {
            Button(action: {
                withOptionalAnimation {
                    toggle()
                }
            }) {
                HStack {
                    Text(title)
                        .customStyle(.subheadline, .onSurface)
                    Spacer()
                    Image(systemName: isActive ? "chevron.up" : "chevron.down")
                        .tint(.onSurface)
                }
                .padding(.horizontal, .xSm)
            }
            
            if isActive {
                content()
                    .transition(.opacity.combined(with: .slide))
                    .padding(.horizontal, .xSm)
                    .padding(.bottom, .sm)
            }
        }
        .animation(.easeInOut, value: isActive)
    }
}
