//
//  CreateTeamView.swift
//  EMLE Teams
//
//  Created by iOSAYed on 24/06/2024.
//

import SwiftUI
import EMLECore

struct CreateTeamView: View {
    enum FocusField: Hashable {
        case teamName
    }
    
    @FocusState var focusedField: FocusField?
    
    @StateObject var viewModel: CreateTeamViewModel
    
    init(coordinator: CreateTeamCoordinating) {
        _viewModel = StateObject(wrappedValue: CreateTeamViewModel(coordinator: coordinator))
    }
    
    var body: some View {
        MainView(viewModel: viewModel) {
            VStack(alignment: .leading) {
                progressView
                navigationBar
                
                switch viewModel.createTeamsSteps {
                case .first:
                    firstStep
                case .second:
                    secondStep
                case .third:
                    thirdStep
                }
            }
            .withLoaderOrView(isLoading: $viewModel.createTeamLoadingState)
        }
        .onAppear{
            viewModel.onAppear()
        }
        .sheet(isPresented: $viewModel.imagePickerPresenting, content: {
            ImagePicker(pickerImage: $viewModel.teamImage, sourceType: viewModel.sourceType)
        })
    }

    private var navigationBar: some View {
        HStack {
            BackButton()
            
            Spacer()
            
            if viewModel.createTeamsSteps != .first && viewModel.createTeamsSteps != .second {
                skipButton
            }
        }
        .addCustomNavigationBarStyle(bottomPadding: 16)
    }

    private var progressView: some View {
        HStack {
            CustomBarProgressView(steps: 4, currentStep: viewModel.createTeamsSteps.rawValue)
        }
    }
    
    private var firstStep: some View {
        VStack(alignment: .leading) {
            headerSection(title: viewModel.createTeamsSteps.headerTitle, subTitle: viewModel.createTeamsSteps.headerSubtitle)
            teamName
            
            Spacer()
            
            buttons(firstAction: viewModel.NextButtonAction(), secondAction: viewModel.nextAction)
        }
    }
    
    private var secondStep: some View {
        VStack(alignment: .leading) {
            headerSection(title: viewModel.createTeamsSteps.headerTitle, subTitle: viewModel.createTeamsSteps.headerSubtitle)
            
            CustomTextView(text: $viewModel.overView)
                .padding(.horizontal,.sm)
            Spacer()
            
            buttons(firstAction: viewModel.NextButtonAction(), secondAction: viewModel.nextAction)
        }
    }
    
    private var thirdStep: some View {
        
        VStack(alignment: .leading) {
            headerSection(title: viewModel.createTeamsSteps.headerTitle, subTitle: viewModel.createTeamsSteps.headerSubtitle)
            
            VStack(alignment: .center){
                image
                
                Spacer()
                
                if viewModel.didSelectImage {
                    countinueButton
                }else {
                    uploadPhoto
                }
            }
            .padding(.vertical)
        }
    }
    
    private func headerSection(title: String, subTitle: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .lineLimit(2)
                .customStyle(.heading1, .onSurface)
            
            Text(subTitle)
                .lineLimit(2)
                .customStyle(.bodySmall, .subtitle)
        }
        .padding(.horizontal)
    }
    
    private var teamName: some View {
        HStack {
            CustomTextField(placeholder: DashboardStrings.teamName.localized,
                            value: $viewModel.teamName)
                .textContentType(.name)
                .focused($focusedField, equals: .teamName)
                .onTapGesture { focusedField = .teamName }
        }
        .padding()
    }
    
    private func buttons(firstAction: EmptyAction, secondAction: EmptyAction) -> some View {
        HStack {
            
            OutlinedButton(title: viewModel.NextButtonTitle, action: firstAction)
            
            Spacer()
            PrimaryButton(title: DashboardStrings.next.localized, action: secondAction)
                .disabled(viewModel.createTeamsSteps.nextButtonDisabled(viewModel: viewModel))
        }
        .padding()
    }
    
    private var skipButton: some View {
        HStack {
            Button(action: {viewModel.skipAction()}, label: {
                Text(DashboardStrings.skip.localized)
                    .customStyle(.subheadline, .subtitle)
                    .frame(width: 50)
            })
        }
    }
    private var image: some View {
        Image(uiImage: viewModel.teamImage.image)
            .resizable()
            .frame(width: 280, height: 280)
            .clipShape(Circle())
    }
    
    private var uploadPhoto: some View {
        PrimaryButton(title: DashboardStrings.uploadPhoto.localized,
                      action: viewModel.onUploadPhotoClick)
           .padding()
    }
    private var countinueButton: some View {
        PrimaryButton(title: DashboardStrings.continueTitle.localized,
                      action: viewModel.nextAction)
           .padding()
    }
}

#Preview {
    CreateTeamView(coordinator: CreateTeamCoordinator(navigationController: UINavigationController(), tabBarController: MainTabBarController()))
}
