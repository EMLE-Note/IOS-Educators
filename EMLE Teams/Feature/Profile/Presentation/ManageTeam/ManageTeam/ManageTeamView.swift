//
//  ManageTeamView.swift
//  EMLE Teams
//
//  Created by iOSAYed on 15/09/2024.
//

import Foundation
import SwiftUI
import EMLECore

struct ManageTeamView: View {
    
    @StateObject var viewModel: ManageTeamViewModel
    
    init(coordinator: ManageTeamCoordinating) {
        _viewModel = StateObject(wrappedValue: ManageTeamViewModel(coordinator: coordinator))
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: .no) {
            navigationBar
            MainView(viewModel: viewModel) {
                VStack(alignment: .leading) {
                    content
                }
            }
        }
        .withCustomOverlayContent(isPresented: $viewModel.isMemberOptionsViewPresented, overlayContent: {
            getSheetView {
                enrollmentOptionsView
                    .padding(.top, .xxBig)
            }
        })
    }
    
    
    
    private var content: some View {
        VStack(alignment: .center) {
            SegmentedControl(selectedIndex: $viewModel.selectedTab,options: viewModel.options)
            memberItems
//            emptyView
           
            Spacer()
            PrimaryButton(title: "Add member", action: viewModel.onAddMemberClick)
                .clipShape(.capsule)
                .padding(.horizontal, .xSm)
        }
        .padding(.sm)
    }
}

//MARK: Views
extension ManageTeamView {
    
    private var navigationBar: some View {
        CustomNavigationBar.navBarWithTrailingButton(title: "Manage Team", editAction: {})
            .padding(.bottom, 8)
            .padding(.horizontal, defaultHPadding)
    }
    
    private var memberItems: some View {
        NoIndicatorsScrollView {
            ForEach(0...20, id: \.self) {index in
                memberItemView
            }
            
            
        }
    }
    
    private var memberItemView: some View {
        HStack(alignment: .center) {
            CustomImageView(image: ImageUrl(urlString: ""),placeholder: .placeholder,contentMode: .fill)
                .clipShape(.circle)
                .frame(width: 41, height: 41)
            
            VStack(alignment: .leading,spacing: .xxSm) {
                Text("Name")
                    .customStyle(.bodySmall, .onSurface)
                Text("Moboile")
                    .customStyle(.caption1, .onSurface)
            }
            Spacer()
            Text("Owner")
                .customStyle(.caption1, .onPrimary)
                .padding(.horizontal, .md)
                .padding(.vertical, .xSm)
                .customBackground(.success)
                .clipShape(.capsule)
            
            Button(action: {viewModel.optionAction()}, label: {
                Image.threeDots
                    .resizable()
                    .frame(width: .md, height: .md)
            })
        }
        .padding(.horizontal, .xxSm)
        .padding(.vertical)
        .withCardShadow()
    }
    
    private var emptyView: some View {
        VStack(alignment: .center) {
            Image.emptyMember
                .resizable()
                .scaledToFit()
                .padding()
                .frame(height: 316)

            Text("You don't have any staff members ")
                .customStyle(.headline, .onSurface)
            Text("When you add members they\nwill appear on this page")
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .customStyle(.bodySmall, .subtitle)
        }
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
    
    private var sheetGrapper: some View {
        Capsule()
            .customFill(.primary)
            .frame(width: 32, height: .xxSm)
    }
    
    private var enrollmentOptionsView: some View {
        VStack(alignment: .leading, spacing: .big) {
            memberOptionsItem(image: .enrollmentDetails, title: FinanceStrings.enrollmentDetails.localized, subtitle: nil, titleColor: .onSurface, didOptionClicked: {viewModel.handleOptionClicked(option: .viewLogs)})
            
            memberOptionsItem(image: .decline, title: FinanceStrings.declineDebit.localized, subtitle: FinanceStrings.addNewPaymentToDeclineDebits.localized, titleColor: .onSurface, didOptionClicked: {viewModel.handleOptionClicked(option: .editMember)})

            memberOptionsItem(image: .resolve, title: FinanceStrings.resolve.localized, subtitle: FinanceStrings.resolveAllTheLearnerDebits.localized, titleColor: .success, didOptionClicked: {viewModel.handleOptionClicked(option: .deactivate)})

            memberOptionsItem(image: .deactivate, title: FinanceStrings.deactivate.localized, subtitle: FinanceStrings.disableTheLearnerAccessToTheCourse.localized, titleColor: .error, didOptionClicked: {viewModel.handleOptionClicked(option: .removeMember)})

        }
        
        .ignoresSafeArea()
    }
    
    private func memberOptionsItem(image:Image,title:String,subtitle:String?,titleColor:ColorStyle,didOptionClicked:EmptyAction) -> some View {
        HStack(alignment: .center,spacing: .md) {
            image
                .frame(width: .xBig, height: .xBig)
            Button(action: {didOptionClicked?()}, label: {
                VStack(alignment: .leading,spacing: .xxSm) {
                    Text(title)
                        .customStyle(.bodyMedium, titleColor)
                    if let subtitle = subtitle {
                        Text(subtitle)
                            .customStyle(.bodySmall, .subtitle)
                    }
                }
            })
            
            Spacer()
        }
    }
}

#Preview {
    ManageTeamView(coordinator: ManageTeamCoordinator(navigationController: UINavigationController(), tabBarController: MainTabBarController()))
}
