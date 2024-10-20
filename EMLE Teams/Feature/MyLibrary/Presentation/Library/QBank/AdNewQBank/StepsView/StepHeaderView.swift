//
//  StepHeaderView.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 12/09/2024.
//

import SwiftUI
import EMLECore

struct StepHeaderView: View {
    var title: String
    var subTitle: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .lineLimit(2)
                .customStyle(.heading2, .primary)
            
            Text(subTitle)
                .lineLimit(2)
                .customStyle(.bodySmall, .subtitle)
        }
        .padding(.horizontal, .xSm)
    }
}
