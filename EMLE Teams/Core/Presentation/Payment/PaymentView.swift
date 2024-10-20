//
//  PaymentView.swift
//  EMLE Teams
//
//  Created by iOSAYed on 11/07/2024.
//

import SwiftUI
import EMLECore

struct PaymentView: View {
    @StateObject var viewModel: PaymentViewModel
//    @Binding 

    init(url:String,coordinator: PaymentCoordinating) {
        _viewModel = StateObject(wrappedValue: PaymentViewModel(url: url, coordinator: coordinator))
    }

    var body: some View {
        navigationBar
        MainView(viewModel: viewModel) {
                if let url = viewModel.paymentURL  {
                    WebView(url:url, isLoading: $viewModel.isLoading) { result in
                        viewModel.paymentResult(result: result)
                    }
                    
                }
           
        }
        .withLoaderOnTopOfView(isLoading: $viewModel.isLoading)
    }
    
    private var navigationBar: some View {
        CustomNavigationBar.Checkout(title: "Checkout")
            .padding(.bottom,8)
            .customBackground(.surface)
            .padding(.horizontal, defaultHPadding)
    }
    
}

#Preview {
    PaymentView(url: "https://google.com", coordinator: PaymentCoordinator(navigationController: UINavigationController()))
}
