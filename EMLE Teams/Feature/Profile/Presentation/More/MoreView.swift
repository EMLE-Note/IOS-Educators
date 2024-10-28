//
//  MoreView.swift
//  EMLE Learners
//
//  Created by Abdelrhman Sultan on 08/05/2024.
//

import SwiftUI
import EMLECore

struct MoreView: View {
    
    @StateObject var viewModel: MoreViewModel
    
    init(coordinator: MoreCoordinating) {
        _viewModel = StateObject(wrappedValue: MoreViewModel(coordinator: coordinator))
    }
    
    var body: some View {
        MainView(viewModel: viewModel) {
            VStack(spacing: 0) {
                
                more
                    .padding(.horizontal, 16)
                
                VStack(spacing: 20){
                    
                    userCard
                    
                    editProfile
                    
                    enrollment
                                        
                    manageTeam
                    
                    teamInvitation

                    helpSupport
                    
                    sendFeedback
                    
                    aboutEMLE
                    
                    shareApp
                    
                    logout
                    
                    Spacer()
                    
                    AppVersionView()
                }
                .padding(16)
            }
            .withLogoutConfirmationDialog(isPresented: $viewModel.isPresentingConfirmationDialog,
                                          action: viewModel.logout)
        }
    }
    
    private var more: some View {
        HStack {
//            Text("MainStrings.more.localized")
            Text("More")
                .customStyle(.subheadline, .onSurface)
            
            Spacer()
        }
    }
    
    private var userCard: some View {
        ProfileCardView(user: viewModel.user)
    }
    
    private var manageTeam: some View {
        NavigationButton(title: "Manage Team",
                         icon: .userEdit, action:
                            viewModel.onManageTeamClick)
    }
    
    private var teamInvitation: some View {
        NavigationButton(title: MoreStrings.teamInvitation.localized,
                         icon: .teamInvitation, action:
                            viewModel.onTeamInvitationsClick)
    }
    
    private var editProfile: some View {
        NavigationButton(title: MoreStrings.editProfile.localized,
                         icon: .userEdit, action:
                            viewModel.onEditProfileClick)
    }
    
    private var enrollment: some View {
        NavigationButton(title: MoreStrings.enrollment.localized,
                         icon: .enrollmentIcon, action:
                            viewModel.onEnrollmentClick)
    }
    
    private var helpSupport: some View {
        NavigationButton(title: MoreStrings.helpSupport.localized,
                         icon: .helpAndSupport,
                         action:
                            viewModel.onHelpAndSupportClick)
    }
    
    private var sendFeedback: some View {
        NavigationButton(title: MoreStrings.sendFeedback.localized,
                         icon: .note,
                         action:
                            viewModel.onSendFeedbackClick)
    }
    
    private var aboutEMLE: some View {
        NavigationButton(title: MoreStrings.aboutEMLE.localized,
                         icon: .aboutEMLE,
                         action:
                            viewModel.onAboutEMLEClick)
    }
    
    private var shareApp: some View {
        NavigationButton(title: MoreStrings.shareApp.localized,
                         icon: .shareApp,
                         action:
                            viewModel.onShareAppClick)
    }
    
    private var logout: some View {
        NavigationButton(title: MoreStrings.logout.localized,
                         icon: .logout,
                         titleColor: .error,
                         iconColor: .error,
                         action:
                            viewModel.onLogoutClick)
    }
}

#Preview {
    MoreView(coordinator: MoreCoordinator(navigationController: UINavigationController(), tabBarController: MainTabBarController()))
}
