//
//  NavigationBarView.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 12/09/2024.
//

import SwiftUI
import EMLECore

struct NavigationBarView: View {
    var title: String

    var body: some View {
        HStack {
            CustomNavigationBar.Checkout(title: title)
                .padding(.bottom, .xxSm)
                .customBackground(.container)
                .padding(.horizontal, defaultHPadding)
            
        }
        .customBackground(.container)
        .padding(.bottom, .xxSm)
    }
}
