//
//  ActivationNewLearnerView.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 13/10/2024.
//

import SwiftUI
import EMLECore

struct ActivationNewLearnerView: View {
    
    enum FocusField: Hashable {
        case phoneNumber
    }
    
    @StateObject var viewModel: ActivationNewLearnerViewModel
    @FocusState var focusedField: FocusField?
    
    init(coordinator: ActivationNewLearnerCoordinating) {
        _viewModel = StateObject(wrappedValue: ActivationNewLearnerViewModel(coordinator: coordinator))
    }
    
    var body: some View {
        MainView(viewModel: viewModel) {
            NoIndicatorsScrollView {
                addNewStudentView
                    .padding()
            }
        }
        .onTapGesture { focusedField = nil }
        .customSheet(isPresented: $viewModel.isPresentCustomSheetView, height: 300, detents: [.medium, .large]) {
            VStack {
                Spacer()
                if let option = viewModel.currentOption {
                    switch option {
                    case .materialType:
                        CustomPickerItems(
                            singleSelectedItem: $viewModel.selectedMaterialType,
                            items: viewModel.materialType,
                            selectedColor: .primary,
                            areItemsEqual: { $0 == $1 }
                        ) {  viewModel.selectMaterialType(viewModel.selectedMaterialType) }
                            .padding()
                    case .materialName:
                        materailNameView
                    case .location:
                        locationView
                    }
                }
                Spacer()
            }
            .background(Color.white)
        }
        .withContentDialog(isPresented: $viewModel.isDialogContentPresented) {
            VStack(spacing: 16) {
                Text(viewModel.selectedGroupName ?? "")
                    .customStyle(.headline, .onSurface)
                
                Text(MoreStrings.selectCourseActivation.localized)
                    .customStyle(.bodyMedium, .onSurface)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack {
                    Text(MoreStrings.selectAll.localized)
                        .customStyle(.bodySmall, .onSurface)
                    
                    Spacer()
                    
                    CustomCheckbox(title: "", isChecked: $viewModel.isAllCoursesSelected) {
                        viewModel.toggleSelectAllCourses()
                    }
                }

                ForEach(viewModel.selectedGroupCourses, id: \.id) { course in
                    HStack {
                        Text(course.name)
                            .customStyle(.bodySmall, .onSurface)
                        
                        Spacer()
                        
                        CustomCheckbox(title: "", isChecked: viewModel.isCourseSelectedBinding(course: course)) {
                        }
                    }
                }

                PrimaryButton(title: MoreStrings.select.localized, action: {
                    viewModel.selectedCourseTapped()
                })
                .disabled(viewModel.selectedCourses.isEmpty && !viewModel.isAllCoursesSelected)
            }
        }
    }
}

#Preview {
    ActivationNewLearnerView(coordinator: ActivationNewLearnerCoordinator(navigationController: UINavigationController(), tabBarController: MainTabBarController()))
}

extension ActivationNewLearnerView {
    private func getSheetView<Content: View>(@ViewBuilder content: @escaping () -> Content) -> some View {
        VStack {
            Spacer()
            
            VStack(spacing: .xSm) {
                content()
            }
            .padding(.horizontal, defaultHPadding)
            .padding(.top, .sm)
            .padding(.bottom, .xxxBig)
            .customBackground(.container)
            .customCornerRadii(.sm, corners: [.topLeft, .topRight])
        }
        .ignoresSafeArea()
    }
    
    private var addNewStudentView: some View {
        VStack(alignment: .leading, spacing: .md) {
            
            Text(MoreStrings.activateNewLearner.localized)
                .customStyle(.headline, .onSurface)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, .xSm)
            
            if viewModel.phoneNumberVisible {
                phoneNumber
            }
            
            if viewModel.isFoundUserSearch {
                HStack(alignment: .center) {
                    if let name = viewModel.searchData?.name, !name.isEmpty {
                        CustomImageView(image: viewModel.searchData?.image, placeholder: Image.coursePlaceholder, contentMode: .fill)
                            .clipShape(Capsule())
                            .frame(width: 36, height: 36)
                            .padding(.xSm)
                    }
                    
                    Text(viewModel.searchData?.name ?? MoreStrings.notFoundUser.localized)
                        .customStyle(.bodySmall, .onSurface)
                        .padding(.leading, 8)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: 60)
                .background(Color.clear)
                .withCardBorder(backgroundColor: .onPrimary, bordered: viewModel.isBorder, borderColor: .neutral)
                .withCardShadow(backgroundColor: .onSurface, cornerRadius: .sm)
                .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
                .onTapGesture {
                    if viewModel.searchData?.name != MoreStrings.notFoundUser.localized {
                        viewModel.toggleBorder()
                        viewModel.phoneNumberVisible = !viewModel.isBorder
                    }
                }
                .disabled(viewModel.searchData?.name == nil)
            }

            customFieldView(
                placeholder: LibraryStrings.selectStudyFiled.localized,
                value: .constant(viewModel.selectedMaterialType.displayName),
                hasChevron: true,
                disable: true
            ) {
                viewModel.presentDialog(for: .materialType)
            }
            
            customFieldView(
                placeholder: LibraryStrings.selectEductionalStatus.localized,
                value: .constant(viewModel.selectedMaterialName.displayName),
                hasChevron: true,
                disable: true
            ) {
                viewModel.presentDialog(for: .materialName)
            }
            
            customFieldView(
                placeholder: LibraryStrings.selectLocation.localized,
                value: .constant(viewModel.locationSelected.displayName),
                hasChevron: true,
                disable: true
            ) {
                viewModel.presentDialog(for: .location)
            }
            
            if !viewModel.isSelectedGroupView {
                coursePrice
            }
            
            buttonView
            
            Spacer()
        }
        .padding(.horizontal, .xSm)
        .customBackground(.container)
    }
}

extension ActivationNewLearnerView {
    private var phoneNumber: some View {
        PhoneNumberTextField(placeholder: RegistrationStrings.phoneNumber.localized,
                             value: $viewModel.phoneNumber,
                             selectedCountry: $viewModel.selectedCountry,
                             selectedAction: viewModel.countryCodeClick)
            .focused($focusedField, equals: .phoneNumber)
            .submitLabel(.search)
            .onTapGesture {
                focusedField = .phoneNumber
                viewModel.searchTapped()
            }
            .onSubmit {
                viewModel.searchTapped()
            }
    }
}

extension ActivationNewLearnerView {
    private var coursePrice: some View {
        VStack {
            ToggleView(isOn: $viewModel.isUseSpecialToggle, title: MoreStrings.useSpecialPrice.localized)
            
            if viewModel.isUseSpecialToggle {
                CustomTextField(title: nil,
                                placeholder: MoreStrings.enterSpecialPrice.localized,
                                value: $viewModel.specialPrice,
                                borderStateColor: .neutral)
                
                CustomTextField(title: nil,
                                placeholder: MoreStrings.ressons.localized,
                                value: $viewModel.reasons,
                                borderStateColor: .neutral)
            }
            
            CustomTextField(title: nil,
                            placeholder: MoreStrings.paidAmount.localized,
                            value: $viewModel.priceAmount,
                            borderStateColor: .neutral)
        }
    }
}

extension ActivationNewLearnerView {
    private var buttonView: some View {
        HStack {
            OutlinedButton(title: MoreStrings.cancel.localized, action: {
                viewModel.cancelTapped()
            }, cornerRadius: 24)
            
            PrimaryButton(title: MoreStrings.activation.localized, action: {
                viewModel.activateTapped()
            })
            .disabled(!viewModel.isActivateButtonEnabled)
            .clipShape(Capsule())
        }
    }
}

extension ActivationNewLearnerView {
    private func customFieldView(title: String? = nil, placeholder: String, value: Binding<String>, hasChevron: Bool = false, disable: Bool = false, onTap: @escaping () -> Void = {}) -> some View {
        CustomTextField(title: title,
                        placeholder: placeholder,
                        value: value,
                        borderStateColor: .neutral,
                        hasChevron: hasChevron,
                        disable: disable)
        .onTapGesture {
            onTap()
        }
    }
}

extension ActivationNewLearnerView {
    private var materailNameView: some View {
        getSheetView {
            NoIndicatorsScrollView {
                TreeItemsView(items: viewModel.materialName,
                              selectedItem: viewModel.selectedMaterialName,
                              selectAction: viewModel.onMaterialSelect)
            }
            .frame(maxHeight: 200)
        }
    }
}

extension ActivationNewLearnerView {
    private var locationView: some View {
        getSheetView {
            NoIndicatorsScrollView {
                TreeItemsView(items: viewModel.locations,
                              selectedItem: viewModel.locationSelected,
                              selectAction: viewModel.onLocationSelect)
            }
            .frame(maxHeight: 200)
        }
    }
}
