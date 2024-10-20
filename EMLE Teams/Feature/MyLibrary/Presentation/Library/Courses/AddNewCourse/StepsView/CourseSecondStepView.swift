//
//  CourseSecondStepView.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 17/09/2024.
//

import Foundation
import EMLECore
import SwiftUI

struct CourseSecondStepView: View {
    @ObservedObject var viewModel: AddNewCourseViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            StepHeaderView(title: viewModel.addCourseSteps.headerTitle, subTitle: viewModel.addCourseSteps.headerSubtitle)
            
            
            NoIndicatorsScrollView {
                toggleView
                
                if viewModel.isPublicExplore {
                    
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
                
                if viewModel.isPublicExplore {
                    emptyTargetView()
                }
                
            }
            Spacer()
            
            PrimaryButton(title: LibraryStrings.addTarget.localized) { viewModel.addAntherTargetTapped() }
                .disabled(!viewModel.canAddNewTarget)
                .clipShape(Capsule())
                .padding()
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
    }
    
    private var toggleView: some View {
        VStack {
            ToggleView(isOn: $viewModel.isPublicExplore, title: LibraryStrings.showCourseExplore.localized)
                .padding(.vertical, .xSm)
        }
    }
    
    private func createTargetedTitle(_ title: String, isExpanded: Bool) -> some View {
        Text(title)
            .customStyle(.subheadline, isExpanded ? .primary : .white)
            .multilineTextAlignment(.leading)
    }
    
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
}

// MARK: - Target View -

extension CourseSecondStepView {
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


// MARK: - Study field -

extension CourseSecondStepView {
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

extension CourseSecondStepView {
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

extension CourseSecondStepView {
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
