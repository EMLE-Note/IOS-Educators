//
//  ManageTeamView.swift
//  EMLE Teams
//
//  Created by iOSAYed on 05/09/2024.
//

import EMLECore
import SwiftUI

struct AddNewMemberView: View {
    enum FocusField: Hashable {
        case phoneNumber
    }
    
    @FocusState var focusedField: FocusField?
    @StateObject var viewModel: AddNewMemberViewModel
    
    init(coordinator: AddNewMemberCoordinating) {
        _viewModel = StateObject(wrappedValue: AddNewMemberViewModel(coordinator: coordinator))
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
        .customSheet(isPresented: $viewModel.isPresentingCountryCodePicker, fraction: 0.9, detents: [.large]) {
            AllCountriesView(selectedCountryIso: viewModel.country.isoCode,
                             selectCountryAction: viewModel.setCountryCode)
        }
        .withCustomOverlayContent(isPresented: $viewModel.isPresentingCoursePermission, overlayContent: {
            getSheetView {
                PermissionsSheet()
            }
        })
    }
    
    private var navigationBar: some View {
        CustomNavigationBar.Checkout(title: "Add New member ")
            .padding(.bottom, 8)
            .padding(.horizontal, defaultHPadding)
    }
    
    private var content: some View {
        VStack(alignment: .leading) {
            headerSection(title: "Member information")
                .padding()
            NoIndicatorsScrollView {
                VStack(alignment: .center) {
                    phoneNumber
                        .withCardBorder(bordered: true, borderColor: .neutral)
                    userCard
                    roleDropdown
                    instractorCard
                    permissionsAndRulesCard
                    
                    fullAccessGrantedToggle
                    
                    Spacer()
                    PrimaryButton(title: "Save", action: {})
                        .clipShape(.capsule)
                        .disabled(.loading)
                }
                .padding(.horizontal)
            }
        }
    }
    
    private func headerSection(title: String) -> some View {
        HStack {
            Text(title)
                .customStyle(.subheadline, .onSurface)
            Spacer()
        }
    }
    
    private var phoneNumber: some View {
        PhoneNumberTextField(placeholder: RegistrationStrings.phoneNumber.localized,
                             value: $viewModel.phoneNumber,
                             selectedCountry: $viewModel.selectedCountry,
                             selectedAction: viewModel.countryCodeClick)
            .keyboardType(.numberPad)
            .textContentType(.telephoneNumber)
            .focused($focusedField, equals: .phoneNumber)
            .onTapGesture {
                focusedField = .phoneNumber
            }
            .overlay(alignment: .trailing) {
                if !viewModel.phoneNumber.isEmpty {
                    RoundImageButton(image: .search, action: viewModel.searchOnMember, iconSize: CGSize(width: 14, height: 14))
                        .padding()
                }
            }
    }
    
    private var userCard: some View {
        HStack {
            HStack(alignment: .center) {
                CustomImageView(image: viewModel.user.image, placeholder: .placeholder)
                    .frame(width: .xxBig, height: .xxBig)
                    .clipShape(.circle)
                    .padding(.horizontal, .xSm)
                Text(viewModel.user.name)
                Spacer()
            }
        }
        .frame(height: 48)
        .withCardBorder(borderColor: .neutral)
    }
    
    private var roleDropdown: some View {
        ExpandableView(label: { Text("Select Role")
                           .customStyle(.bodySmall, .subtitle)
                       },
                       content: {
                           roleList
                               .padding(.vertical, 12)
                       })
    }
    
    private var roleList: some View {
        ForEach(0 ... 1, id: \.self) { index in
            Text("role \(index)")
        }
    }
    
    private var instractorCard: some View {
        HStack(alignment: .center) {
            ForEach(InstructorOptions.allCases, id: \.self) { option in
                CustomRadioButton(
                    title: option.title,
                    isSelected: viewModel.selectedInstractorOption == option,
                    action: {
                        viewModel.selectedInstractorOption = option
                    }
                )
                if option == .instructor {
                    Spacer()
                }
            }
        }
        .padding()
    }
    
    private var permissionsAndRulesCard: some View {
        VStack(alignment: .leading, spacing: .xSm) {
            headerSection(title: "Permissions & Rules")
            
            viewAccessCard(title: "content", action: {
                viewModel.selectedOptionType = .contents
                viewModel.isPresentingCoursePermission = true
            })
            viewAccessCard(title: "Enrollments", action: {
                viewModel.selectedOptionType = .enrollments
                viewModel.isPresentingCoursePermission = true
            })
            viewAccessCard(title: "Finances", action: {
                viewModel.selectedOptionType = .finances
                viewModel.isPresentingCoursePermission = true
            })
            viewAccessCard(title: "Managements", action: {
                viewModel.selectedOptionType = .managements
                viewModel.isPresentingCoursePermission = true
            })
        }
    }
    
    private func viewAccessCard(title: String, action: EmptyAction) -> some View {
        HStack(alignment: .center) {
            Text(title)
                .customStyle(.bodySmall, .onSurface)
                .padding(.horizontal, .sm)
            Spacer()
            Button(action: { action?() }) {
                Text("view Access")
                    .customStyle(.caption1, .onSecondary)
                    .padding(.sm)
                    .frame(height: 24)
                    .customBackground(.secondary)
            }
            .customCornerRadii(.xSm, corners: .allCorners)
            .padding(.sm)
        }
        .frame(height: 48)
        .withCardShadow(cornerRadius: 6)
    }
    
    private var fullAccessGrantedToggle: some View {
        HStack(alignment: .center) {
            Toggle(isOn: $viewModel.isFullAccessGranted) {
                Text("Give the user full access permissions")
                    .customStyle(.bodySmall, .onSurface)
            }
            .toggleStyle(SwitchToggleStyle(tint: Color.primaryColor))
            .padding()
        }
    }
    
    private func PermissionsSheet() -> some View {
        VStack {
            PermissionsView(permissions: viewModel.teamPermissions())
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

#Preview {
    AddNewMemberView(coordinator: AddNewMemberCoordinator(navigationController: UINavigationController(), tabBarController: MainTabBarController()))
}
