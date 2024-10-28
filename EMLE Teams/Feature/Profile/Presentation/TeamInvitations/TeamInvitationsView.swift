//
//  TeamInvitationsView.swift
//  EMLE Teams
//
//  Created by iOSAYed on 27/10/2024.
//

import Foundation
import SwiftUI
import EMLECore

struct TeamInvitationsView: View {
    
    @StateObject var viewModel: TeamInvitationsViewModel
    
    init(coordinator: TeamInvitationsCoordinating) {
        _viewModel = StateObject(wrappedValue: TeamInvitationsViewModel(coordinator: coordinator))
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: .no) {
            MainView(viewModel: viewModel) {
                navigationBar
                if !viewModel.invitationsList.isEmpty{
                    invitationsList
                        .redacted(viewModel.getInvitationListLoadingState)
                        .withShimmerOverlay()
                }else {
                    emptyView
                }
                Spacer()
            }
            .padding(.horizontal)
        }
    }

}

//MARK: Views
extension TeamInvitationsView {
    
    private var navigationBar: some View {
        CustomNavigationBar.Checkout(title: "Team Invitations")
            .padding(.bottom, 8)
            .padding(.horizontal, defaultHPadding)
    }
    
    private func invitationCard(item: Invitation) -> some View {
        VStack {
            HStack(alignment: .center, spacing: .md) {
                CustomImageView(image: ImageUrl(urlString: ""))
                    .frame(width: 40, height: 40)
                    .clipShape(.circle)
                Text("\(item.teamName) team has invited you to join their team as a \(item.role)")
                    .lineLimit(2)
                    .customStyle(.bodySmall, .onSurface)
                Spacer()
            }
            
            HStack(alignment: .center, spacing: .xBig) {
                OutlinedButton(title: FinanceStrings.decline.localized,action: {viewModel.onDeclineClick(id: item.invitationId)}, height: 40, cornerRadius:.xBig, textColor: .error,borderColor: .error)
                    .frame(width: 140)
                PrimaryButton(title: "Accept",action: {viewModel.onAcceptClick(id: item.invitationId)}, height: 40)
                    .clipShape(.capsule)
            }
        }
        .padding()
        .withCardShadow()
    }
    
    private var invitationsList: some View {
        NoIndicatorsScrollView {
            ForEach(viewModel.invitationsList, id: \.id){ item in
                invitationCard(item: item)
            }
        }
    }
    
    private var emptyView: some View {
        VStack(alignment: .center) {
            Spacer()
            Image.emptyMember
                .resizable()
                .scaledToFit()
                .padding()
                .frame(height: 316)

            Text("You don't have any invitations yet")
                .customStyle(.headline, .onSurface)
            Text("When others invite you to join their team\n it will appear here")
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .customStyle(.bodySmall, .subtitle)
            Spacer()
        }
    }
   
}

#Preview {
    TeamInvitationsView(coordinator: TeamInvitationsCoordinator(navigationController: UINavigationController()))
}
