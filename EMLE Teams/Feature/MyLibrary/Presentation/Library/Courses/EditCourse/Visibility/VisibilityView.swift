//
//  VisibilityView.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 13/08/2024.
//

import SwiftUI
import EMLECore

struct VisibilityView: View {
    @State private var activeSection: ActiveSection = .none
    @State private var suheduleDate = Date()
    @StateObject var viewModel: VisibilityViewModel
    
    init(courseId: Int, coordinator: VisibilityViewCoordinating) {
        _viewModel = StateObject(wrappedValue: VisibilityViewModel(courseId: courseId, coordinator: coordinator))
    }
    
    var body: some View {
        navigationBar
        MainView(viewModel: viewModel) {
            VStack(spacing: .xBig) {
                publishView
                
                divider
                
                suheduleView
            }
            .padding()
            Spacer()
            customButtons
        }
        
    }
}

#Preview {
    VisibilityView(courseId: -1, coordinator: VisibilityViewCoordinator(navigationController: UINavigationController(), tabBarController: MainTabBarController()))
}

// MARK: - Navigation View -

extension VisibilityView {
    private var navigationBar: some View {
        HStack {
            CustomNavigationBar.Checkout(title: LibraryStrings.visibility.localized)
                .padding(.bottom, .xxSm)
                .customBackground(.container)
                .padding(.horizontal, defaultHPadding)
        }
    }
}

// MARK: - Action Toggle -

extension VisibilityView {
    private func toggleSection(_ section: ActiveSection) {
        if activeSection == section {
            activeSection = .none
        } else {
            activeSection = section
        }
    }
    
    private var divider: some View {
        Divider()
            .padding(.vertical, .xSm)
        
    }
}

extension VisibilityView {
    private var publishView: some View {
        VStack {
            CollapsibleSection(
                title: LibraryStrings.publishNow.localized,
                isActive: activeSection == .publishNow,
                toggle: { toggleSection(.publishNow) }
            ) {
                VStack(alignment: .leading) {
                    ForEach(VisibilityPublishType.allCases, id: \.self) { option in
                        CustomRadioButton(
                            title: option.title,
                            description: option.desction,
                            isSelected: viewModel.selectedDateOption == option,
                            action: {
                                viewModel.selectedDateOption = option
                            }
                        )
                    }
                    .padding(.vertical, .xSm)
                }
                .padding(.horizontal, .sm)
            }
        }
    }
}

// MARK: - Suhedule View -

extension VisibilityView {
    private var suheduleView: some View {
        VStack {
            CollapsibleSection(
                title: LibraryStrings.schedule.localized,
                isActive: activeSection == .schedule,
                toggle: { toggleSection(.schedule) }
            ) {
                Text(LibraryStrings.publishAsPublic.localized)
                    .customStyle(.bodySmall, .onSurface)
                    .padding(.horizontal, .sm)
                
                Text(viewModel.publishDate)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .customBackground(.container)
                    .customCornerRadius(.sm)
                    .withCardBorder(borderColor: .neutral)
                    .onTapGesture {
                        self.viewModel.isPickerVisible.toggle()
                    }
                
                CustomDatePicker(selectedDateString: $viewModel.publishDate, isVisible: $viewModel.isPickerVisible)
            }
        }
    }
}

// MARK: - Apply Button -

extension VisibilityView {
    private var customButtons: some View {
        VStack {
            PrimaryButton(title: LibraryStrings.applyChanges.localized) { viewModel.onApplyChangeClick() }
                .clipShape(Capsule())
            
            TextButton(title: LibraryStrings.discardChanges.localized) { viewModel.onDiscardChangeClick() }
        }
        .padding(.horizontal, .md)
    }
}
