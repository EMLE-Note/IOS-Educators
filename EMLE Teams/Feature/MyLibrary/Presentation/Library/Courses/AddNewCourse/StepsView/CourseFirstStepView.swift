//
//  CourseFirstStepView.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 17/09/2024.
//

import Foundation
import EMLECore
import SwiftUI

struct CourseFirstStepView: View {
    @ObservedObject var viewModel: AddNewCourseViewModel

    var body: some View {
        VStack(alignment: .leading) {
            NoIndicatorsScrollView {
                CreateFormView(
                    headerTitle: viewModel.addCourseSteps.headerTitle,
                    headerSubtitle: viewModel.addCourseSteps.headerSubtitle,
                    identifierPlaceholder: LibraryStrings.courseIdPH.localized,
                    titlePlaceholder: LibraryStrings.courseTitlePH.localized,
                    pricePlaceholder: LibraryStrings.coursePricePH.localized,
                    overviewPlaceholder: LibraryStrings.courseOverviewPH.localized,
                    identifierTitle: LibraryStrings.courseId.localized,
                    titleTitle: LibraryStrings.courseTitle.localized,
                    priceTitle: LibraryStrings.price.localized,
                    overviewTitle: LibraryStrings.courseOverview.localized,
                    identifier: $viewModel.courseId,
                    title: $viewModel.courseTitle,
                    price: $viewModel.coursePrice,
                    overview: $viewModel.courseOverview
                )
                .padding(.bottom, .xSm)
                
                showPriceAndStudentCountView
                
                showPriceAndStudentCountView
                
                groupView
            }
            
            Spacer()
        }
        .customSheet(isPresented: $viewModel.isPresentGroupSheetView,
                     height: 300,
                     detents: [.medium, .large]) {
            VStack {
                Spacer()
                CustomPickerItems(
                    selectedItems: $viewModel.selectedGroups,
                    items: viewModel.allGroups,
                    selectedColor: .primary,
                    isMultiSelect: true,
                    areItemsEqual: { $0.groupId == $1.groupId }
                ) {  let selectedIds = viewModel.selectedGroups.map { $0.groupId }
                    print("Selected group IDs: \(selectedIds)") }
                    .padding()
            }
            .background(Color.white)
        }
    }
}

// MARK: - Groups -

extension CourseFirstStepView {
    private var groupView: some View {
        VStack(alignment: .leading) {
            CustomTextField(title: LibraryStrings.groups.localized,
                            placeholder: LibraryStrings.selectNewGroup.localized,
                            value: $viewModel.group,
                            borderStateColor: .neutral,
                            hasChevron: true,
                            disable: true)
            .onTapGesture {
                viewModel.onSelectedNewGroupsTapped()
            }
            
            listGroups
        }
        .padding(.horizontal, .md)
        .padding(.vertical, .md)
    }
}

// MARK: - List of Groups -

extension CourseFirstStepView {
    private var listGroups: some View {
        VStack {
            ForEach(viewModel.selectedGroups, id: \.self) { group in
                HStack {
                    Text(group.name)
                        .customStyle(.bodySmall, .onSurface)
                    
                    Spacer()
                    
                    Image.deletePermanently
                        .frame(width: 24, height: 24)
                        .onTapGesture {
                            viewModel.onRemoveGroupTapped(group: group)
                        }
                }
                .padding(.sm)
            }
        }
    }
}

// MARK: - Show price and student Count

extension CourseFirstStepView {
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
