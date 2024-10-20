//
//  EditProfileView.swift
//  EMLE Learners
//
//  Created by Abdelrhman Sultan on 10/05/2024.
//

import SwiftUI
import EMLECore

struct EditProfileView: View {
    
    enum FocusField: Hashable {
        case name
    }
    
    @FocusState var focusedField: FocusField?
    
    @StateObject var viewModel: EditProfileViewModel
    
    init(coordinator: EditProfileCoordinating) {
        _viewModel = StateObject(wrappedValue: EditProfileViewModel(coordinator: coordinator))
    }
    
    var body: some View {
        MainView(viewModel: viewModel) {
            VStack(spacing: 0) {
                navigationView
                
                ScrollView {
                    VStack(spacing: 20) {
                        VStack(spacing: 8) {
                            
                            if viewModel.isProfileImageChanged {
                                selectedImage
                            } else {
                                image
                            }
                            
                            changePhoto
                        }
                        
                        name
                        
                        mobile
                        
                        location
                        
                        HStack(spacing: 16) {
                            educationStatus
                            
                            graduationYear
                        }
                        
                        field
                        CustomTextView(text: $viewModel.overView,placeholder: RegistrationStrings.addOverview.localized)
                    }
                }
                .padding(16)
                
                Spacer()
                
                saveChanges
                    .padding(16)
            }
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
            .withCustomOverlayContent(isPresented: $viewModel.isPresentLocation) {
                VStack {
                    Spacer()
                    
                    LocationsList(locations: viewModel.locations, selectAction: viewModel.selectLocation)
                }
            }
            .withCustomOverlayContent(isPresented: $viewModel.isPresentingSourceImagePicker) {
                VStack {
                    
                    Spacer()
                    
                    ImagePickerSource(uploadPhotoAction: viewModel.onUploadPhotoClick,
                                      takePhotoAction: viewModel.onTakePhotoClick)
                }
            }
            .withCustomOverlayContent(isPresented: $viewModel.isPresentingImagePicker) {
                VStack {
                    
                    ImagePicker(pickerImage: $viewModel.profileImage, sourceType: viewModel.sourceType)
                        .padding(.top, 50)
                }
            }
            .customSheet(isPresented: $viewModel.isPresentingCountryCodePicker, fraction: 0.9,detents:[.large]) {
                AllCountriesView(selectedCountryIso: viewModel.country.isoCode,
                                 selectCountryAction: viewModel.setCountryCode)
            }
            .withLoadingState(loadingState: viewModel.fieldsLoadingState,
                              failureViewClickAction: viewModel.onAppear)
            .withLoadingState(loadingState: viewModel.profileDataLoadingState,
                              failureViewClickAction: viewModel.onAppear)
            .withLoadingState(loadingState: viewModel.editProfileLoadingState,
                              failureViewClickAction: viewModel.reloadLoadingState)
        }
    }
    
    private var tabGesture: some Gesture {
        TapGesture().onEnded {
            focusedField = nil
        }
    }
    
    private var navigationView: some View {
        HStack(spacing: 16) {
            
            BackButton()
            
            Text(MoreStrings.editProfile.localized)
                .customStyle(.subheadline, .onSurface)
            
            Spacer()
        }
    }
}

extension EditProfileView {
    private var image: some View {
        CustomImageView(image: viewModel.profileData.image, placeholder: .placeholder)
            .frame(width: 94, height: 94)
            .clipShape(Circle())
    }
    
    private var selectedImage: some View {
        Image(uiImage: viewModel.profileImage.image)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 94, height: 94)
            .clipShape(Circle())
    }
    
    private var changePhoto: some View {
        Button {
            viewModel.onChangePhotoClick()
        } label: {
            Text(MoreStrings.changePhoto.localized)
                .customStyle(.bodySmall, .secondary)
        }
    }
    
    private var name: some View {
        CustomTextField(title: RegistrationStrings.name.localized,
                        placeholder: RegistrationStrings.name.localized,
                        value: $viewModel.profileData.name)
    }
    
    private var mobile: some View {
        PhoneNumberTextField(title: RegistrationStrings.phoneNumber.localized,
                             placeholder: RegistrationStrings.phoneNumber.localized,
                             value: $viewModel.profileData.mobile,
                             checker: $viewModel.phoneNumberChecker,
                             selectedCountry: $viewModel.selectedCountry,
                             selectedAction: viewModel.onCountryCodeClick)
        .customOnChange(of: viewModel.profileData.mobile,
                        action: viewModel.validatePhone)
        .disabled(true)
    }
    
    private var location: some View {
        Button {
            withAnimation {
                viewModel.isPresentLocation.toggle()
            }
        } label: {
            CustomTextField(title: MoreStrings.country.localized,
                            placeholder: MoreStrings.country.localized,
                            value: $viewModel.locationSelected.name,
                            hasChevron: true,
                            disable: true)
        }
    }
    
    private var field: some View {
        Button {
            withAnimation {
                viewModel.isPresentFieldsView.toggle()
            }
        } label: {
            CustomTextField(title: RegistrationStrings.studyingField.localized,
                            placeholder: RegistrationStrings.studyingField.localized,
                            value: $viewModel.selectedField.name,
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
    
    private var saveChanges: some View {
        PrimaryButton(title: MoreStrings.saveChanges.localized,
                      action: viewModel.onSaveChangesClick)
        .disabled(viewModel.isSaveChangesDisable)
    }
}

#Preview {
    EditProfileView(coordinator: EditProfileCoordinator(navigationController: UINavigationController()))
}
