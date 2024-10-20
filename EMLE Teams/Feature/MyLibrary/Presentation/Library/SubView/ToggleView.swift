//
//  ToggleView.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 10/08/2024.
//

import SwiftUI
import EMLECore

struct ParentView: View {
    @State private var isToggleOn: Bool = false

    var body: some View {
        VStack {
            ToggleView(isOn: $isToggleOn, title: "Course settings") {
                print("Toggle state is now \(isToggleOn ? "ON" : "OFF")")
            }
        }
    }
}

struct ToggleView: View {
    @Binding var isOn: Bool
    var title: String
    var action: (() -> Void)?
    var tint: Color?
    
    var body: some View {
        HStack(alignment: .center) {
            Toggle(isOn: $isOn) {
                Text("\(title)")
                    .customStyle(.bodyMedium, .onSurface)
            }
            .toggleStyle(SwitchToggleStyle(tint: tint ?? .primaryColor))
            .onChange(of: isOn) { _ in
                action?()
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
}

// Preview
struct ParentView_Previews: PreviewProvider {
    static var previews: some View {
        ParentView()
    }
}
