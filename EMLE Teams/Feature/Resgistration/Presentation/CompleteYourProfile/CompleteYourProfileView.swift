//
//  CompleteYourProfileView.swift
//  EMLE Learners
//
//  Created by Abdelrhman Sultan on 20/04/2024.
//

import SwiftUI
import EMLECore

struct CompleteYourProfileView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    enum FocusField: Hashable {
        case name
        case jobTitle
    }
    
    @FocusState var focusedField: FocusField?
    
    @StateObject var viewModel: CompleteYourProfileViewModel
    
    init(coordinator: CompleteYourProfileCoordinating) {
        _viewModel = StateObject(wrappedValue: CompleteYourProfileViewModel(coordinator: coordinator))
    }
    
    var body: some View {
        
        MainView(viewModel: viewModel) {
            VStack(spacing: 0) {
                navigationBar
                
                ScrollView(showsIndicators: false) {
                    
                    VStack(spacing: 32) {
                        
                        HStack(spacing: 8) {
//                            stepView
//                            stepView
//                            stepView
//                            stepView
                            CustomBarProgressView(steps: 4, currentStep: viewModel.step.rawValue)
                        }
                        
                        switch viewModel.step {
                        case .step1:
                            view1
                                .transition(.slide)
                        case .step2:
                            view2
                                .transition(.slide)
                        case .step3:
                            view3
                                .transition(.slide)
                        case .step4:
                            view4
                                .transition(.slide)
                            
                        }
                        
                    }
                }
                .padding(16)
                
            }
            .onTapGesture { focusedField = nil }
            .navigationBarBackButtonHidden(true)
            .sheet(isPresented: $viewModel.imagePickerPresenting, content: {
                ImagePicker(pickerImage: $viewModel.profileImage, sourceType: viewModel.sourceType)
            })
            .withLoadingState(loadingState: viewModel.loadingState,
                              failureViewClickAction: viewModel.resetLoadingState)
            .withLoadingState(loadingState: viewModel.fieldsLoadingState,
                              failureViewClickAction: viewModel.resetFieldsLoadingState)
            .withCustomOverlayContent(isPresented: $viewModel.isPresentFieldsView) {
                VStack {
                    Spacer()
                    
                    FieldsView(fields: viewModel.displayedFields,
                               selectAction: viewModel.selectField,
                               parentField: viewModel.parentField,
                               backAction: viewModel.onBackClick,
                               isPresented: $viewModel.isPresentFieldsView,
                               isDoneButtonDisabled: viewModel.isDoneButtonDisabled)
                }
            }
            .withCustomOverlayContent(isPresented: $viewModel.isPresentGraduationYears) {
                VStack {
                    Spacer()
                    
                    GraduationYearsList(years: viewModel.graduationYears, selectAction: viewModel.selectYear)
                }
            }
            .withCustomOverlayContent(isPresented: $viewModel.isPresentEducationStatuses) {
                VStack {
                    Spacer()
                    
                    EducationStatusesList(educationStatuses: viewModel.educationStatuses, selectAction: viewModel.selectEducationStatus)
                }
            }
        }
    }
    
    private var tapGesture: some Gesture {
        TapGesture().onEnded {
            focusedField = nil
        }
    }
    
    private var navigationBar: some View {
        HStack {
            BackButton()
            
            Spacer()
        }
    }
    
    private var view1: some View {
        VStack(spacing: 20) {
            VStack(spacing: 0) {
                tellUsYourName
                
                justTellUsWhatYouWantUsToCallYou
            }
            
            name
            
            
            Spacer()
            
            continueButton
        }
    }
    
    private var view4: some View {
        VStack(spacing: 16) {
            VStack(spacing: 4) {
                skip
                
                uploadYourPhoto
                
                choosePhotoToPersonalizeYourAccount
            }
            
            Spacer()
            
            image
            
            Spacer()
            
            uploadPhoto
            
            takePhoto
            
            if viewModel.didSelectImage {
                continueButton
            }
        }
    }
    
    private var view2: some View {
        VStack(spacing: 24) {
            letPersonalizeYourLearning
            
            VStack(spacing: 16) {
                
                jobTitle
                studyingField
                
//                educationStatus
                
//                graduationYear
            }
            
            Spacer()
            
            continueButton
        }
    }
    
    private var view3: some View {
        VStack(spacing: 24) {
            AddOverview
            
            VStack(spacing: 16) {
                CustomTextView(text: $viewModel.overView)
            }
            
            Spacer()
            
            continueButton
        }
    }

    
}

extension CompleteYourProfileView {
    
    private var tellUsYourName: some View {
        HStack {
            Text(RegistrationStrings.tellUsYourName.localized)
                .customFont(size: 28, weight: ._500, lineHeight: 34)
                .customForeground(.onSurface)
            
            Spacer()
        }
    }
    
    private var justTellUsWhatYouWantUsToCallYou: some View {
        HStack {
            Text(RegistrationStrings.justTellUsWhatYouWantUsToCallYou.localized)
                .customFont(size: 14, weight: ._400, lineHeight: 24)
                .customForeground(.onSurface)
            Spacer()
        }
    }
    
    private var name: some View {
        CustomTextField(placeholder: RegistrationStrings.name.localized,
                        value: $viewModel.name)
        .textContentType(.name)
        .focused($focusedField, equals: .name)
        .onTapGesture { focusedField = .name }
    }
    
    private var jobTitle: some View {
        CustomTextField(placeholder: RegistrationStrings.jobTitle.localized,
                        value: $viewModel.jobTitle)
        .textContentType(.name)
        .focused($focusedField, equals: .name)
        .onTapGesture { focusedField = .jobTitle }
    }
    
    private var continueButton: some View {
        PrimaryButton(title: RegistrationStrings.continueCase.localized, action: viewModel.onContinueClick)
            .disabled(viewModel.isContinueDisable)
            .simultaneousGesture(tapGesture)
    }
}

extension CompleteYourProfileView {
    private var skip: some View {
        HStack {
            Spacer()
            
            Button {
                viewModel.onSkipClick()
            } label: {
                Text(BasicStrings.skip.localized)
                    .customFont(size: 14, weight: ._600, lineHeight: 20)
                    .customForeground(.onSurface)
            }
        }
    }
    
    private var uploadYourPhoto: some View {
        Text(RegistrationStrings.uploadYourPhoto.localized)
            .customFont(size: 28, weight: ._500, lineHeight: 34)
            .customForeground(.onSurface)
    }
    
    private var choosePhotoToPersonalizeYourAccount: some View {
        Text(RegistrationStrings.choosePhotoToPersonalizeYourAccount.localized)
            .customFont(size: 14, weight: ._400, lineHeight: 24)
            .customForeground(.onSurface)
    }
    
    private var image: some View {
        Image(uiImage: viewModel.profileImage.image)
            .resizable()
            .frame(width: 280, height: 280)
            .clipShape(Circle())
    }
    
    private var uploadPhoto: some View {
        PrimaryButton(title: BasicStrings.uploadPhoto.localized,
                      action: viewModel.onUploadPhotoClick)
    }
    
    private var takePhoto: some View {
        SecondaryButton(title: BasicStrings.takePhoto.localized,
                      action: viewModel.onTakePhotoClick)
    }
}

extension CompleteYourProfileView {
    private var letPersonalizeYourLearning: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(RegistrationStrings.specialization.localized)
                    .customStyle(.heading1, .onSurface)
                Text(RegistrationStrings.enterYourDataToMakeItEasier.localized)
                    .customStyle(.bodySmall, .subtitle)
            }
            Spacer()
        }
    } 
    private var AddOverview: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(RegistrationStrings.addOverview.localized)
                    .customStyle(.heading1, .onSurface)
                Text(RegistrationStrings.tellYourStudentsMoreAboutYourAcademic.localized)
                    .customStyle(.bodySmall, .subtitle)
            }
            Spacer()
        }
    }
    
    private var educationStatus: some View {
        Button {
            withAnimation {
                viewModel.isPresentEducationStatuses.toggle()
            }
        } label: {
            CustomTextField(title: RegistrationStrings.educationStatus.localized,
                            placeholder: RegistrationStrings.educationStatus.localized,
                            value: $viewModel.educationStatusSelected.name,
                            hasChevron: true,
                            disable: true)
        }
    }
    
    private var graduationYear: some View {
        Button {
            withAnimation {
                viewModel.isPresentGraduationYears.toggle()
            }
        } label: {
            CustomTextField(title: RegistrationStrings.graduationYear.localized,
                            placeholder: RegistrationStrings.graduationYear.localized,
                            value: $viewModel.graduationYearSelected.displayName,
                            hasChevron: true,
                            disable: true)
        }
    }
    
    private var studyingField: some View {
        Button {
            withAnimation {
                viewModel.isPresentFieldsView.toggle()
            }
        } label: {
            CustomTextField(title: RegistrationStrings.studyingField.localized,
                            placeholder: RegistrationStrings.studyingField.localized,
                            value: $viewModel.studyingFieldsSelected.name,
                            hasChevron: true,
                            disable: true)
        }
    }
}

#Preview {
    CompleteYourProfileView(coordinator: CompleteYourProfileCoordinator(navigationController: UINavigationController()))
}

