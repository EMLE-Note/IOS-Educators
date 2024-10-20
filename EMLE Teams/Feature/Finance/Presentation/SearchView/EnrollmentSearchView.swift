//
//  EnrollmentSearchView.swift
//  EMLE Teams
//
//  Created by iOSAYed on 18/08/2024.
//

import EMLECore
import SwiftUI

struct EnrollmentSearchView: View {
    enum FocusedField {
        case searchBar
    }
    
    @FocusState var focusedField: FocusedField?
    @FocusState private var isDeclineTextFieldFocused: Bool

    let namespace: Namespace.ID
    let searchBarId: Namespace.ID
    @StateObject var viewModel: EnrollmentViewModel
    
    private var closeAction: EmptyAction

    init(namespace: Namespace.ID,
         searchBarId: Namespace.ID,
         searchContentType: SearchContentType,
         closeAction: EmptyAction,
         coordinator: EnrollmentViewCoordinating)
    {
        _viewModel = StateObject(wrappedValue: EnrollmentViewModel(coordinator: coordinator))
        self.closeAction = closeAction
        self.namespace = namespace
        self.searchBarId = searchBarId
    }
    
    var body: some View {
        MainView(viewModel: viewModel) {
            VStack(spacing: 0) {
                searchSearchBar
                    .padding(.horizontal, defaultHPadding)
                    .onTapGesture {
                        focusedField = .searchBar
                    }
                
                VStack(spacing: 0) {
                    
                    searchEnrollmentsResults
                    .redacted(viewModel.searchLoadingState)
                    
                    Spacer(minLength: 0)
                }
            }
        }
        .withSecondCustomDialog(isPresented: $viewModel.isDialogPresent, image: .placeholder, title: viewModel.enrollmentOptions.dialogTitle, message: viewModel.enrollmentOptions.dialogMessage, yesButtonTitle: viewModel.enrollmentOptions.dialogYesButtonTitle, yesButtonAction: viewModel.onYesButtonClicked, noButtonTitle:FinanceStrings.noCancel.localized)
        .customSheet(isPresented: $viewModel.isEnrollmentOptionsViewPresented,height: 300, detents: [.medium], content: {
            getSheetView {
                enrollmentOptionsView
            }
        })
        .customSheet(isPresented: $viewModel.isDeclineOptionsViewPresented,height: 200, detents: [.medium], content: {
            getSheetView {
                declineView
            }
        })
        
        .onTapGesture {
            focusedField = nil
        }
        .onAppear {
            focusedField = .searchBar
        }
    }
}

extension EnrollmentSearchView {
    private var searchSearchBar: some View {
        SearchBar(searchText: $viewModel.searchText,
                  closeAction: {
                      closeAction?()
                  })
                  .focused($focusedField, equals: .searchBar)
                  .matchedGeometryEffect(id: searchBarId, in: namespace)
    }
    
    private var searchEnrollmentsResults: some View {
        SearchResultView(results: viewModel.searchEnrollmentsResults,
                         contentType: .enrollments,
                         selectAction: { enrollment in
            viewModel.selectedEnrollment = enrollment.content
            viewModel.handleOptionClicked(option: .details)
        }) { enrollment in
            viewModel.selectedEnrollment = enrollment.content
            viewModel.isEnrollmentOptionsViewPresented = true
        }
    }
}

#Preview {
    @Namespace var namespace
    @Namespace var searchBarId
    
    return EnrollmentSearchView(namespace: namespace,
                      searchBarId: searchBarId,
                      searchContentType: .transactions,
                      closeAction: nil,
                      coordinator: EnrollmentViewCoordinator(navigationController: UINavigationController(), tabBarController: MainTabBarController()))
}

extension EnrollmentSearchView {
    private var enrollmentOptionsView: some View {
        VStack(alignment: .leading, spacing: .sm) {
            emrollmentOptionsItem(image: .enrollmentDetails, title: FinanceStrings.enrollmentDetails.localized, subtitle: nil, titleColor: .onSurface, didOptionClicked: {viewModel.handleOptionClicked(option: .details)})
            emrollmentOptionsItem(image: .decline, title: FinanceStrings.declineDebit.localized, subtitle: FinanceStrings.addNewPaymentToDeclineDebits.localized, titleColor: .onSurface, didOptionClicked: {viewModel.handleOptionClicked(option: .decline)})
            emrollmentOptionsItem(image: .warning, title: FinanceStrings.sendWarning.localized, subtitle: FinanceStrings.remindTheLearnerT0PayHisDebits.localized, titleColor: .onSurface, didOptionClicked: {viewModel.handleOptionClicked(option: .warning)})
            emrollmentOptionsItem(image: .resolve, title: FinanceStrings.resolve.localized, subtitle: FinanceStrings.resolveAllTheLearnerDebits.localized, titleColor: .success, didOptionClicked: {viewModel.handleOptionClicked(option: .resolve)})
            emrollmentOptionsItem(image: .deactivate, title: FinanceStrings.deactivate.localized, subtitle: FinanceStrings.disableTheLearnerAccessToTheCourse.localized, titleColor: .error, didOptionClicked: {viewModel.handleOptionClicked(option: .deactivate)})
        }
        
        .ignoresSafeArea()
    }

    private func emrollmentOptionsItem(image:Image,title:String,subtitle:String?,titleColor:ColorStyle,didOptionClicked:EmptyAction) -> some View {
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
    
    private var declineView: some View {
        VStack(alignment:.leading, spacing: .xSm) {
            HStack(alignment: .center,spacing: .md) {
                Image.decline
                    .frame(width: .xBig, height: .xBig)
                Text(FinanceStrings.declineDebit.localized)
                    .customStyle(.bodyMedium, .onSurface)
                Spacer()
            }
            
            VStack(alignment:.leading, spacing: .xxSm) {
                Text(FinanceStrings.declineDebit.localized)
                    .customStyle(.bodyMedium, .onSurface)
                textField(placeholder: "\(FinanceStrings.example.localized) 1500 \(viewModel.currancy)", value: $viewModel.declineDebitValue, isFocused: $isDeclineTextFieldFocused)
            }
            PrimaryButton(title: FinanceStrings.saveChanges.localized, action: viewModel.onSaveDeclineChangesClicked)
                .clipShape(.capsule)
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
            sheetGrapper
                .padding(.top,.xSm)
            VStack(spacing: 8) {
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
    
    @ViewBuilder
    private func textField(placeholder: String, value: Binding<String>, isFocused: FocusState<Bool>.Binding) -> some View {
        TextField(placeholder, text: value)
            .keyboardType(.numberPad)
            .focused(isFocused)
            .padding()
            .cornerRadius(.xBig)
            .overlay(
                RoundedRectangle(cornerRadius: .xBig)
                    .stroke(isFocused.wrappedValue ? Color.primaryColor : Color.neutral, lineWidth: 2)
                    .scaleEffect(isFocused.wrappedValue ? 1.02 : 1)
                    .animation(.easeOut(duration: 0.2), value: isFocused.wrappedValue)
            )
    }
}
