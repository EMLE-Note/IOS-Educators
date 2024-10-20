//
//  BlurView.swift
//  EMLE Teams
//
//  Created by iOSAYed on 07/08/2024.
//

import Foundation
import SwiftUI

struct BlurView: UIViewRepresentable {
    var style: UIBlurEffect.Style

    func makeUIView(context: Context) -> UIVisualEffectView {
        let effect = UIBlurEffect(style: style)
        let view = UIVisualEffectView(effect: effect)
        return view
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}
