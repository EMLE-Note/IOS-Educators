//
//  CongratsCreateTeamView.swift
//  EMLE Teams
//
//  Created by iOSAYed on 04/09/2024.
//

import EMLECore
import SwiftUI

struct CongratsCreateTeamView: View {
    @StateObject var viewModel: CongratsCreateTeamViewModel
    
    init(coordinator: CongratsCreateTeamCoordinating) {
        _viewModel = StateObject(wrappedValue: CongratsCreateTeamViewModel(coordinator: coordinator))
    }
    
    var body: some View {
        MainView(viewModel: viewModel) {
            VStack(spacing: 0) {
                VStack(spacing: .xBig) {
                    image
                    
                    VStack(alignment: .center, spacing: .xSm) {
                        congrats
                        subtitle
                    }
                    
                    Buttons
                }
                .padding(16)
            }
            .navigationBarBackButtonHidden(true)
        }
    }
    
    private var image: some View {
        Image.createTeamSuccess
            .resizable()
            .frame(width: 230, height: 230)
    }
    
    private var congrats: some View {
        Text(DashboardStrings.yourTeamHasBeenCreatedSuccessfully.localized)
            .multilineTextAlignment(.center)
            .customStyle(.heading1, .onSurface)
    }
    
    private var subtitle: some View {
        Text(DashboardStrings.ourAdminsWillReviewYourAccount.localized)
            .multilineTextAlignment(.center)
            .customStyle(.bodyMedium, .subtitle)
    }
    
    private var Buttons: some View {
        VStack(alignment: .center,spacing: .md) {
            PrimaryButton(title: DashboardStrings.contactCustomerService.localized,action: {
                //contact with customer sevice 
            },
                          leadingIcon:.send)
                .clipShape(.capsule)
            
            Button(action: {
                viewModel.onGoToHomeClicked()
            }, label: {
                HStack {
                    Text(DashboardStrings.returnToDashboard.localized)
                        .customStyle(.buttonText, .primary)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 48)
                .customBackground(.white)
                .overlay {
                    RoundedRectangle(cornerRadius: 25.0)
                        .stroke(lineWidth: 2.0)
                        .customForeground(.primary)
                }
               
            }
            )
        }
    }
}

#Preview {
    CongratsCreateTeamView(coordinator: CongratsCreateTeamCoordinator(navigationController: UINavigationController()))
}
