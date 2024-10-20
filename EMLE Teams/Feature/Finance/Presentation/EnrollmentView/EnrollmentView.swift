//
//  EnrollmentView.swift
//  EMLE Teams
//
//  Created by iOSAYed on 07/08/2024.
//

import SwiftUI
import EMLECore

struct EnrollmentView: View {
    @Namespace private var namespace
    @Namespace private var searchBarId
    
    @FocusState private var isDeclineTextFieldFocused: Bool
    @StateObject var viewModel: EnrollmentViewModel
    
    init(coordinator: EnrollmentViewCoordinating) {
        _viewModel = StateObject(wrappedValue: EnrollmentViewModel(coordinator: coordinator))
    }
   
    
    var body: some View {
            switch viewModel.screenType {
            case .content:
                enrollmentView
            case .filters:
                filterView
            case .search:
                searchView
            }
    }
        
       
}

#Preview {
    EnrollmentView(coordinator: EnrollmentViewCoordinator(navigationController: UINavigationController(), tabBarController: MainTabBarController()))
}

extension EnrollmentView {
    @ViewBuilder
    private var enrollmentView: some View {
        navigationBar
        MainView(viewModel: viewModel) {
            VStack(alignment: .center, spacing: .big) {
                searchBarView
                if !viewModel.isShowEmptyView {
                    paginatedBody
                } else {
                    empty
                }
                
                Spacer()
            }
            .ignoresSafeArea(edges: .bottom)
        }
        .withLoaderOnTopOfView(isLoading: $viewModel.declineCourseLoadingState)
        .withSecondCustomDialog(isPresented: $viewModel.isDialogPresent, image: .placeholder, title: viewModel.enrollmentOptions.dialogTitle, message: viewModel.enrollmentOptions.dialogMessage, yesButtonTitle: viewModel.enrollmentOptions.dialogYesButtonTitle, yesButtonAction: viewModel.onYesButtonClicked, noButtonTitle:FinanceStrings.noCancel.localized)
        .customSheet(isPresented: $viewModel.isEnrollmentOptionsViewPresented,height: 300, detents: [.fixed(300)], content: {
            getSheetView {
                enrollmentOptionsView
            }
        })
        .customSheet(isPresented: $viewModel.isDeclineOptionsViewPresented,height: 200, detents: [.medium], content: {
            getSheetView {
                declineView
            }
        })
    }
}

extension EnrollmentView {
    
    private var navigationBar: some View {
        CustomNavigationBar.Checkout(title: FinanceStrings.enrollmentDebits.localized)
            .padding(.bottom, 8)
            .customBackground(.container)
            .padding(.horizontal, defaultHPadding)
    }
    
    private var searchBarView: some View {
        VStack(spacing: 16) {
            HStack(spacing: 12) {
                enrollmentSearchBar
                filtersButton
            }
        }
        .padding(.horizontal, defaultHPadding)
    }
    
    private var paginatedBody: some View {
        PaginationView(canGetANewPage: viewModel.enrollmentCoursesList.canGetANewPage,
                       getNewPageAction: viewModel.getNewEnrollmentCourses)
        {
                enrollmentCardsView(enrollments: viewModel.enrollmentCoursesList.pageContent)
                    .redacted(viewModel.enrollmentLoadingState)
                    .withShimmerOverlay()
           
        }
    }
    
    private var enrollmentSearchBar: some View {
        SearchBar(searchText: .constant(""))
            .matchedGeometryEffect(id: searchBarId, in: namespace)
            .frame(height: 50)
            .background {
                RoundedRectangle(cornerRadius: .xSm)
                    .customStroke(.neutral)
            }
            .onTapGesture {
                viewModel.onSearchBarClicked()
            }
    }
    
    private var filtersButton: some View {
        PrimaryImageButton(image: .filters,
                           action: viewModel.onFiltersClicked)
    }
    
    private func enrollmentCardsView(enrollments: [Enrollment]) -> some View {
        VStack {
            if !viewModel.enrollmentCoursesList.pageContent.isEmpty {
                NoIndicatorsScrollView {
                    ForEach(enrollments, id: \.self) { enrollment in
                        EnrollmentCardView(enrollment: enrollment, isHaveOptionButton: true){}
                    onOptionButtonClicked: {enrollment in
                        viewModel.selectedEnrollment = enrollment
                        viewModel.onThreeDotsOptionsClicked() }
                    }
                }
                .padding(.sm)
            }
        }
        
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
    
    private var empty: some View {
        VStack(alignment: .center) {
            Image.emptyIcon
                .resizable()
                .frame(width: 120, height: 80)
            Text(FinanceStrings.noTransactionsYet.localized)
                .customStyle(.heading2, .onSurface)
            Text(FinanceStrings.noTransactionsMessage.localized)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .customStyle(.bodySmall, .subtitle)
        }
    }
    private var sheetGrapper: some View {
        Capsule()
            .customFill(.primary)
            .frame(width: 32, height: .xxSm)
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
    
    @ViewBuilder
    private var filterView: some View {
        EnrollmentFilterView(filters: $viewModel.filterOptions, closeAction: viewModel.onFiltersClose)
    }
    
    @ViewBuilder
    private var searchView: some View {
        EnrollmentSearchView(namespace: namespace, searchBarId: searchBarId, searchContentType: .enrollments, closeAction: viewModel.onSearchBarCloseClick, coordinator: viewModel.coordinator)
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
    
    
    
}
