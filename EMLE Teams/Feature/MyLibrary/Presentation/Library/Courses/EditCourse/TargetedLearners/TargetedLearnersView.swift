//
//  TargetedLearnersView.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 13/08/2024.
//

import SwiftUI
import EMLECore

struct TargetedLearnersView: View {
    @StateObject var viewModel: TargetedLearnersViewModel
    
    init(courseId: Int, coordinator: TargetedLearnersViewCoordinating) {
        _viewModel = StateObject(wrappedValue: TargetedLearnersViewModel(courseId: courseId, coordinator: coordinator))
    }
    
    var body: some View {
        MainView(viewModel: viewModel) {
            navigationBar
            toggleView
            
            showPriceAndStudentCountView
            
            NoIndicatorsScrollView {
                if viewModel.showOnCourseExplore {
                    
                    VStack {
                        ForEach(viewModel.targets.indices, id: \.self) { index in
                            ExpandableView(
                                isExpandedState: $viewModel.isExpandableStates[index],
                                closedBackgroundColor: .primary,
                                expandedBackgroundColor: .container,
                                expandButtonColor: .white,
                                borderColor: .clear,
                                label: {
                                    self.createTargetedTitle(viewModel.targets[index].name, isExpanded: viewModel.isExpandableStates[index])
                                },
                                content: {
                                    targetView(for: index)
                                }
                            )
                            .padding(.horizontal, .sm)
                        }
                    }
                }
                
                emptyTargetView()
            }
            
            Spacer()
            customButtons
        }
        .customSheet(isPresented: $viewModel.isPresentCustomSheetView, height: 300, detents: [.medium, .large]) {
            VStack {
                Spacer()
                if let option = viewModel.currentOption {
                    switch option {
                    case .filed:
                        studyFieldView
                    case .education:
                        educationStatusView
                    case .university:
                        institutionView
                    }
                }
                Spacer()
            }
            .background(Color.white)
        }
        .withLoadingState(loadingState: viewModel.fieldsLoadingState,
                          failureViewClickAction: viewModel.onAppear)
    }
}

#Preview {
    TargetedLearnersView(courseId: -1, coordinator: TargetedLearnersViewCoordinator(navigationController: UINavigationController(), tabBarController: MainTabBarController()))
}

// MARK: - Navigation View -

extension TargetedLearnersView {
    private var navigationBar: some View {
        HStack {
            CustomNavigationBar.Checkout(title: LibraryStrings.targetLearner.localized)
                .padding(.bottom, .xxSm)
                .customBackground(.container)
                .padding(.horizontal, defaultHPadding)
            
            Spacer()
        }
        .customBackground(.container)
        .padding(.bottom, .xSm)
    }
    
    private func createTargetedTitle(_ title: String, isExpanded: Bool) -> some View {
        Text(title)
            .customStyle(.subheadline, isExpanded ? .primary : .white)
            .multilineTextAlignment(.leading)
    }
    
    func getSheetView<Content: View>(@ViewBuilder content: @escaping () -> Content) -> some View {
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
    
    private func optionalContentView() -> some View {
        VStack(alignment: .leading, spacing: .md) {
            
        }
        .padding(.horizontal, .xSm)
        .customBackground(.container)
    }
}


// MARK: - Toggle View -

extension TargetedLearnersView {
    private var toggleView: some View {
        VStack {
            ToggleView(isOn: $viewModel.showOnCourseExplore, title: LibraryStrings.showCourseExplore.localized)
                .padding(.vertical, .xSm)
        }
    }
}

// MARK: - Show price and student Count

extension TargetedLearnersView {
    private var showPriceAndStudentCountView: some View {
        HStack {
            VStack(alignment: .leading, spacing: .sm) {
                CustomCheckBox(isOn: $viewModel.isShowPrice, title: "Show Ptice")
                CustomCheckBox(isOn: $viewModel.isShowStudentCount, title: "Show Student Count")
            }
            
            Spacer()
        }
        .padding(.horizontal, .md)
    }
}

// MARK: - custom Field View -

extension TargetedLearnersView {
    private func customFieldView(title: String, placeholder: String, value: Binding<String>, hasChevron: Bool = false, disable: Bool = false, onTap: @escaping () -> Void = {}) -> some View {
        CustomTextField(title: title,
                        placeholder: placeholder,
                        value: value,
                        borderStateColor: .neutral,
                        hasChevron: hasChevron,
                        disable: disable)
        .padding(.horizontal, .md)
        .padding(.vertical, .xSm)
        .onTapGesture {
            onTap()
        }
    }
}

// MARK: - Target View -

extension TargetedLearnersView {
    private func targetView(for index: Int) -> some View {
        VStack {
            customFieldView(
                title: LibraryStrings.courseTitle.localized,
                placeholder: LibraryStrings.putDescriptiveTitle.localized,
                value: .constant(viewModel.targets[index].name)
            )
            
            customFieldView(
                title: LibraryStrings.field.localized,
                placeholder: LibraryStrings.selectStudyFiled.localized,
                value: .constant(viewModel.targets[index].field.displayName),
                hasChevron: true,
                disable: true
            ) {
                viewModel.currentIndex = index 
                viewModel.presentDialog(for: .filed)
            }
            
            customFieldView(
                title: LibraryStrings.educationalStatus.localized,
                placeholder: LibraryStrings.selectEductionalStatus.localized,
                value: .constant(viewModel.targets[index].type.displayName),
                hasChevron: true,
                disable: true
            ) {
                viewModel.currentIndex = index
                viewModel.presentDialog(for: .education)
            }
            
            customFieldView(
                title: LibraryStrings.university.localized,
                placeholder: LibraryStrings.selectUniversity.localized,
                value: .constant(viewModel.targets[index].institution.displayName),
                hasChevron: true,
                disable: true
            ) {
                viewModel.currentIndex = index
                viewModel.presentDialog(for: .university)
            }
        }
        .customBackground(.container)
        .customCornerRadii(.sm, corners: .allCorners)
        .padding()
    }
}

extension TargetedLearnersView {
    private func emptyTargetView() -> some View {
        VStack {
            customFieldView(
                title: LibraryStrings.courseTitle.localized,
                placeholder: LibraryStrings.putDescriptiveTitle.localized,
                value: $viewModel.newTarget.name
            )
            
            customFieldView(
                title: LibraryStrings.field.localized,
                placeholder: LibraryStrings.selectStudyFiled.localized,
                value: .constant(viewModel.newTarget.field.displayName),
                hasChevron: true,
                disable: true
            ) {
                viewModel.presentDialog(for: .filed)
            }
            
            customFieldView(
                title: LibraryStrings.educationalStatus.localized,
                placeholder: LibraryStrings.selectEductionalStatus.localized,
                value: .constant(viewModel.newTarget.type.displayName),
                hasChevron: true,
                disable: true
            ) {
                viewModel.presentDialog(for: .education)
            }
            
            customFieldView(
                title: LibraryStrings.university.localized,
                placeholder: LibraryStrings.selectUniversity.localized,
                value: .constant(viewModel.newTarget.institution.displayName),
                hasChevron: true,
                disable: true
            ) {
                viewModel.presentDialog(for: .university)
            }
        }
        .customBackground(.container)
        .customCornerRadii(.sm, corners: .allCorners)
        .padding()
    }
}

// MARK: - Apply Button -

extension TargetedLearnersView {
    private var customButtons: some View {
        VStack {
            PrimaryButton(title: LibraryStrings.addTarget.localized) { viewModel.addTargetTapped() }
                .disabled(!viewModel.canAddNewTarget)
                .clipShape(Capsule())
            
            PrimaryButton(title: LibraryStrings.applyChanges.localized) { viewModel.onApplyChangeClick() }
                .clipShape(Capsule())
            
            TextButton(title: LibraryStrings.discardChanges.localized) { viewModel.onDiscardChangeClick() }
            
            
        }
        .padding(.horizontal, .md)
    }
}

// MARK: - Study field -

extension TargetedLearnersView {
    private var studyFieldView: some View {
        getSheetView {
            
            NoIndicatorsScrollView {
                
                TreeItemsView(parentItem: viewModel.parentField,
                              backAction: viewModel.onFieldsBackClick,
                              items: viewModel.displayedFields,
                              selectedItem: viewModel.selectedField,
                              selectAction: viewModel.onFieldSelect,
                              doneAction: viewModel.onFieldsDoneClick)
            }
            .frame(maxHeight: 400)
        }
    }
}

// MARK: - Education Status -

extension TargetedLearnersView {
    private var educationStatusView: some View {
        getSheetView {
            NoIndicatorsScrollView {
                TreeItemsView(items: viewModel.educationStatuses,
                              selectedItem: viewModel.educationStatusSelected,
                              selectAction: viewModel.onEducationStatusSelect)
            }
            .frame(maxHeight: 200)
        }
        
    }
}

// MARK: - Education Status -

extension TargetedLearnersView {
    private var institutionView: some View {
        getSheetView {
            NoIndicatorsScrollView {
                TreeItemsView(items: viewModel.institution,
                              selectedItem: viewModel.selectedInstitution,
                              selectAction: viewModel.onInstitutionSelect)
            }
            .frame(maxHeight: 200)
        }
        
    }
}
