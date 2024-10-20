//
//  PopupViewManager.swift
//  EMLE Teams
//
//  Created by iOSAYed on 05/07/2024.
//

import Combine
import SwiftUI

class PopupViewManager: ObservableObject {

    @Published var isPresented: Bool = false {
        didSet {
            if !self.isPresented {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
                    self?.content = AnyView(EmptyView())
                    self?.onDismiss = nil
                }
            }
        }
    }
    
    @Published var isLoading: Bool = false

    @Published private(set) var content: AnyView

    private(set) var onDismiss: (() -> Void)?

    var defaultAnimation: Animation = .interpolatingSpring(stiffness: 300.0, damping: 30.0, initialVelocity: 100.0)

    init() {
        self.content = AnyView(EmptyView())
    }

    func updatePopupSheet<T>(isPresented: Bool? = nil, content: (() -> T)? = nil, onDismiss: (() -> Void)? = nil) where T: View {
        self.isLoading = false
        if let content = content {
            self.content = AnyView(content())
        }
        if let onDismiss = onDismiss {
            self.onDismiss = onDismiss
        }
        if let isPresented = isPresented {
            self.isPresented = isPresented
        }
    }

    func closePopupSheet() {
        self.isLoading = false
        self.isPresented = false
        self.onDismiss?()
    }
}
