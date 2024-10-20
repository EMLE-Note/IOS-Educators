//
//  DashboardView.swift
//  EMLE Teams
//
//  Created by iOSAYed on 14/06/2024.
//

import EMLECore
import SwiftUI

struct DashboardView: View {
    @StateObject var viewModel: DashboardViewModel
    
    init(coordinator: DashboardViewCoordinating) {
        _viewModel = StateObject(wrappedValue: DashboardViewModel(coordinator: coordinator))
    }

    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            navigationBar
            MainView(viewModel: viewModel) {
                VStack(alignment: .center) {
                    if viewModel.selectedTeamId == nil {
                        createTeamContent
                    }else {
                        content
                    }
                }
            }
        }
        .withLoadingState(loadingState: viewModel.getMyTeamsLoadingState)
        .withCustomOverlayContent(isPresented: $viewModel.isPresentingLoadingInitializing, overlayContent: {
            loadingOverlay
        })
        .customSheet(isPresented: $viewModel.isPresentingMyTeamsList, fraction: 0.5, detents: [.medium]) {
            getSheetView {
                MyTeamsListView(teams: $viewModel.myTeams, selectedTeamId: viewModel.selectedTeamId?.id ?? -1) { teamId in
                    print(teamId)
                    viewModel.changeTeamId(to: teamId)
                    viewModel.setupInitializingTeamDashboardLoading()
                } onClickedOnCreateNewTeam: {
                    viewModel.createTeamAction()
                }
            }
        }
    }
    
    private var content: some View {
        VStack(alignment: .center, spacing: .no) {
            if let team = viewModel.selectedTeam, team.hasCurrentDeal ?? false{
                Text("Welecome")
                    .customStyle(.heading1, .primary)
                Text("Your Dashbord comming soon...")
                    .customStyle(.caption2, .subtitle)
            }else {
                undergoingView
            }
        }
    }

    private var navigationBar: some View {
        dashboardNavigationBar(
            title: DashboardStrings.dashboard.localized,
            teamImage: viewModel.selectedTeam?.image,
            teamTitle: viewModel.selectedTeam?.name,
            teamAction: viewModel.teamListAction,
            notificationAction: viewModel.notificationAction,
            settingAction: viewModel.settingAction
        )
            .padding(.bottom, 16)
            .customBackground(.container)
            .padding(.horizontal, defaultHPadding)
    }
    
    private var welecomeCard: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Welcome aboard, \(viewModel.currentUser?.name ?? "")!")
                    .customStyle(.heading2, .onSurface)
                    .multilineTextAlignment(.leading)
                    .lineLimit(1)
                
                Text(DashboardStrings.startSharingYourKnowledgeAndContent.localized)
                    .customStyle(.bodySmall, .subtitle)
                    .lineLimit(2)
            }
            Image(.welcomeImg)
                .frame(width: 64, height: 85)
        }
        .padding(defaultHPadding)
        .customBackground(.onPrimary)
        .customCornerRadius(12)
        .padding(8)
        .shadow(color: .black.opacity(0.05), radius: 15, x: 0, y: 15)
    }
    
    private func createAccountCard(title: String, subTitle: String, buttonTitle: String, buttonAction: EmptyAction, isIndevidual: Bool = false) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .customStyle(.headline, .onSurface)
                .multilineTextAlignment(.leading)
                .lineLimit(1)
            
            Text(subTitle)
                .customStyle(.bodySmall, .subtitle)
                .lineLimit(2)
            
            if isIndevidual {
                OutlinedButton(title: buttonTitle, action: buttonAction)
                    .padding(.top, 12)
                
            } else {
                PrimaryButton(title: buttonTitle, action: buttonAction)
                    .padding(.top, 12)
            }
        }
        .padding(defaultHPadding)
        .padding(.bottom, 16)
    }
    
    private var undergoingView: some View {
        VStack(alignment: .center, spacing: .xSm) {
            Image.createTeamSuccess
                .frame(width: 210, height: 200)
                .padding(.md)
            Text(DashboardStrings.yourAccountIsCurrentlyUndergoing.localized)
                .customStyle(.headline, .onSurface)
                .multilineTextAlignment(.center)
            Text(DashboardStrings.ourAdminsIsReviewingYourAccount.localized)
                .customStyle(.bodyMedium, .subtitle)
                .multilineTextAlignment(.center)
        }
    }
    
    private var createTeamContent: some View {
        VStack(alignment: .center, spacing: .no) {
            welecomeCard
            createAccountCard(title: DashboardStrings.createATeam.localized, subTitle: DashboardStrings.build_a_team_of_instructors.localized, buttonTitle: DashboardStrings.createTeam.localized, buttonAction: viewModel.createTeamAction)
            
            createAccountCard(title: DashboardStrings.continueAsIndividual.localized, subTitle: DashboardStrings.build_a_team_of_instructors.localized, buttonTitle: DashboardStrings.continueAsIndividual.localized, buttonAction: viewModel.countinueAsIndividualAction, isIndevidual: true)
            Spacer()
        }
    }
    
   private var loadingOverlay: some View {
           VStack {
               Spacer()
               HStack {
                   ProgressView()
                   Text("Initializing your team dashboard")
                       .customStyle(.headline, .onSurface)
                       .padding(.vertical, .xSm)
               }
               .padding()
               .customBackground(.container)
               .withCardShadow(cornerRadius: .sm)
               Spacer()
           }
       }
    
    private var sheetGrapper: some View {
        Capsule()
            .customFill(.primary)
            .frame(width: 32, height: .xxSm)
    }

    private func getSheetView<Content: View>(@ViewBuilder content: @escaping () -> Content) -> some View {
        VStack {
            Spacer()
            VStack(spacing: 8) {
                sheetGrapper
                content()
            }
            .padding(.horizontal, defaultHPadding)
            .padding(.top, 12)
            .padding(.bottom, 32)
            .customBackground(.container)
            .customCornerRadii(.xxxBig, corners: [.topLeft, .topRight])
        }
        .ignoresSafeArea()
    }
}

extension DashboardView {
    private func dashboardNavigationBar(title:String,teamImage:ImageUrl?, teamTitle:String?, teamAction:EmptyAction,notificationAction:EmptyAction,settingAction:EmptyAction) -> some View {
            HStack {
                if let teamImage = teamImage, let teamTitle = teamTitle {
                    Button(action: {teamAction?()}) {
                        CustomImageView(image: teamImage, placeholder: .placeholder)
                            .frame(width: .xBig, height: .xBig)
                            .clipShape(.circle)
                    }
                   Text(teamTitle)
                       .customStyle(.bodySmall, .onSurface)
                   Spacer()
                    
                    Text(title)
                        .customStyle(.subheadline, .onSurface)
                    
                    Spacer()
               }else {
                   Text(title)
                       .customStyle(.subheadline, .onSurface)
                   Spacer()
               }
                HStack {
                    Button {
                        notificationAction?()
                    } label: {
                        Image.notificationIcon
                            .frame(width: 16, height: 14)
                    }
                    
                    Button {
                        settingAction?()
                    } label: {
                        Image.settingIcon
                            .frame(width: 16, height: 14)
                    }

                }
            }
        }
}

#Preview {
    DashboardView(coordinator: DashboardViewCoordinator(navigationController: UINavigationController(), tabBarController: MainTabBarController()))
}
