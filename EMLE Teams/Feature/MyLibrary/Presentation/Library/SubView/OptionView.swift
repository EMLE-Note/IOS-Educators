//
//  OptionView.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 13/08/2024.
//

import SwiftUI
import EMLECore

struct OptionView: View {
    var icon: Image
    var title: String
    var description: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                icon
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32, height: 32)

                VStack(alignment: description.isEmpty ? .center : .leading) {
                    Text(title)
                        .customStyle(.bodyMedium, .onSurface)
                    
                    if !description.isEmpty {
                        Text(description)
                            .customStyle(.bodySmall, .subtitle)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct OptionView_Previews: PreviewProvider {
    static var previews: some View {
        OptionView(
            icon: Image(systemName: "gear"),
            title: "Example Title",
            description: "This is a detailed description of the example ."
        )
    }
}
