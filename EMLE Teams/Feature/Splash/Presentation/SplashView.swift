//
//  SplashView.swift
//  EMLE Teams
//
//  Created by iOSAYed on 08/06/2024.
//

import SwiftUI
import EMLECore

struct SplashView: View {
    
    @StateObject var viewModel: SplashViewModel
    
    init(coordinator: SplashCoordinating) {
        _viewModel = StateObject(wrappedValue: SplashViewModel(coordinator: coordinator))
    }
    
    var body: some View {
        VStack {
            VStack(alignment:.leading) {
                HStack{
                    Spacer()
                    upperVectorImage
                }
            }
            
            fullLogo
                .opacity(viewModel.logoOpacity)
                .scaleEffect(viewModel.logoScale)
            Spacer()
            
            humanUpdate
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .customBackground(.surface)
        .onAppear { viewModel.onAppear() }
        .navigationBarHidden(true)
        .padding(.bottom,40)
    }
    private var upperVectorImage: some View {
        Image.upperVectorImage
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 250, height: 250)
    }
    
    private var fullLogo: some View {
        Image.fullLogo
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 250, height: 250)
    }
    
    private var humanUpdate: some View {
        Image.humanUpdate
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(height: 150)
            .frame(maxWidth: .infinity)
    }
}

struct SplashView_Previews: PreviewProvider {
    
    static let coordinator = SplashCoordinator(navigationController: UINavigationController())
    
    static var previews: some View {
        SplashView(coordinator: coordinator)
    }
}
