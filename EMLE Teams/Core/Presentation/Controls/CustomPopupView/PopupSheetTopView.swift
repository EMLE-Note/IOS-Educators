//
//  PopupSheetTopView.swift
//  EMLE Teams
//
//  Created by iOSAYed on 05/07/2024.
//

import Foundation
import SwiftUI

struct PopupSheetTopView: View {
    var headerColor: Color = .primary
    var body: some View {
        ZStack {
            headerColor
                .customCornerRadii(24, corners: [.topLeft, .topRight])
                .frame(height: 40)
            Color.black
                .opacity(0.2)
                .frame(width: 48, height: 6)
                .clipShape(Capsule())
                .padding(.bottom, 6)
        }
    }
}

#Preview {
    PopupSheetTopView(headerColor: .blue)
}

