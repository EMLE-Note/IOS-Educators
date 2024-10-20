//
//  SecurityOptionView.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 19/09/2024.
//

import Foundation
import SwiftUI
import EMLECore

struct SecurityOptionView: View {
    let title: String
    @Binding var isSelected: Bool
    let optionType: SecurityOptionType
    let customLayerViews: [CustomLayerView]?
    let onInfoTap: () -> Void
    let customBackground: ColorStyle
    
    init(
        title: String,
        isSelected: Binding<Bool>,
        optionType: SecurityOptionType,
        customLayerViews: [CustomLayerView]? = nil,
        onInfoTap: @escaping () -> Void,
        customBackground: ColorStyle = .container
    ) {
        self.title = title
        self._isSelected = isSelected
        self.optionType = optionType
        self.customLayerViews = customLayerViews
        self.onInfoTap = onInfoTap
        self.customBackground = customBackground
    }
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                CustomCheckBox(isOn: $isSelected, title: title)
                    .padding()
                Spacer()
                Image.aboutLayers
                    .resizable()
                    .frame(width: 16, height: 16)
                    .padding(.xSm)
                    .onTapGesture {
                        onInfoTap()
                    }
            }
            .padding(.horizontal, .xxSm)
            
            if let customViews = customLayerViews {
                ForEach(customViews, id: \.title) { customLayerView in
                    customLayerView
                }
            }
        }
        .customBackground(customBackground)
        .customCornerRadii(.sm, corners: .allCorners)
        .padding(.horizontal, .md)
    }
}
