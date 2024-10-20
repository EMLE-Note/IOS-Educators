//
//  EnrollmentFilterView.swift
//  EMLE Teams
//
//  Created by iOSAYed on 11/08/2024.
//

import EMLECore
import SwiftUI

struct EnrollmentFilterView: View {
    @StateObject var viewModel: EnrollmentFilterViewModel

    init(filters: Binding<EnrollmentFilterOptions>, closeAction: EmptyAction) {
        _viewModel = StateObject(wrappedValue: EnrollmentFilterViewModel(filters: filters, closeAction: closeAction))
    }

    @FocusState private var isMinTextFieldFocused: Bool
    @FocusState private var isMaxTextFieldFocused: Bool

    var body: some View {
        MainView(viewModel: viewModel) {
            navigationBar
            NoIndicatorsScrollView {
                VStack(alignment: .leading) {
                    enrollmentDate
                    paidAmount
                    enrollmentTypeView
                    materialTypeView
                    PaidAmountFilterView
                    applyFilterButton
                }
                .customBackground(.container)
            }
        }
        .padding(.md)
    }

    private var navigationBar: some View {
        HStack(alignment: .center) {
            Button(action: {viewModel.onFilterClosed()},
                   label: {
                Image.closeIcon
                    .frame(width: 12, height: 12)
                   })
            Spacer()
            Text("Filter")
                .customStyle(.heading3, .onSurface)
            Spacer()
            Button(action: {viewModel.onClearClick()},
                   label: {
                       Text("Clear")
                
                    .customStyle(.bodySmall, viewModel.isFilterSelected ? .primary : .subtitle)
                   })
            .disabled(viewModel.isClearButtonDisabled)
        }
        .padding(.bottom, .big)
        .customBackground(.container)
    }

    private var divider: some View {
        VStack {
            Divider()
        }
        .padding(.vertical, .md)
    }

    private var enrollmentDate: some View {
        VStack(alignment: .leading, spacing: .xSm) {
            Text("Sort by")
                .customStyle(.headline, .primary)
            Text("Enrollment date")
                .customStyle(.subheadline, .onSurface)
            ForEach(DateFilterOptions.allCases, id: \.self) { option in
                CustomRadioButton(
                    title: option.rawValue,
                    isSelected: viewModel.selectedDateOption == option,
                    action: {
                        viewModel.selectedDateOption = option
                    }
                )
            }
            divider
        }
    }

    private var paidAmount: some View {
        VStack(alignment: .leading, spacing: .xSm) {
            Text("Paid Amount")
                .customStyle(.subheadline, .onSurface)
            ForEach(AmountFilterOptions.allCases, id: \.self) { option in
                CustomRadioButton(
                    title: option.rawValue,
                    isSelected: viewModel.selectedAmountOption == option,
                    action: {
                        viewModel.selectedAmountOption = option
                    }
                )
            }
            divider
        }
    }

    private var enrollmentTypeView: some View {
        VStack(alignment: .leading) {
            Text("Type of Enrollment")
                .customStyle(.subheadline, .onSurface)
            ForEach(EnrollmentTypeFilterOptions.allCases, id: \.self) { type in
                CustomCheckbox(
                    title: type.rawValue,
                    isChecked: Binding(
                        get: { viewModel.selectedEnrollmentTypes.contains(type) },
                        set: { _ in
                            if viewModel.selectedEnrollmentTypes.contains(type) {
                                viewModel.selectedEnrollmentTypes.remove(type)
                            } else {
                                viewModel.selectedEnrollmentTypes.insert(type)
                            }
                        }
                    ),
                    action: {}
                )
            }
            divider
        }
    }

    private var materialTypeView: some View {
        VStack(alignment: .leading) {
            Text("Type of Material")
                .customStyle(.subheadline, .onSurface)
            ForEach(MaterialTypeFilterOptions.allCases, id: \.self) { type in
                CustomCheckbox(
                    title: type.rawValue,
                    isChecked: Binding(
                        get: { viewModel.selectedMaterialTypes.contains(type) },
                        set: { _ in
                            if viewModel.selectedMaterialTypes.contains(type) {
                                viewModel.selectedMaterialTypes.remove(type)
                            } else {
                                viewModel.selectedMaterialTypes.insert(type)
                            }
                        }
                    ),
                    action: {}
                )
            }
            divider
        }
    }

    private var PaidAmountFilterView: some View {
        VStack(alignment: .leading) {
            Text("Paid Amount")
                .customStyle(.subheadline, .onSurface)

            HStack(alignment: .center, spacing: .xSm) {
                textField(placeholder: "0 EGP", value: $viewModel.minAmount, isFocused: $isMinTextFieldFocused)
                Text("-")
                    .customStyle(.subheadline, .subtitle)
                textField(placeholder: "500 EGP", value: $viewModel.maxAmount, isFocused: $isMaxTextFieldFocused)
            }
            .padding(.xxSm)
        }
    }

    private var applyFilterButton: some View {
        PrimaryButton(title: "Apply Filter", action: viewModel.onApplyClick)
            .clipShape(.capsule)
            .disabled(!viewModel.isFilterSelected)
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

#Preview {
    TransactionsFilterView(filters: .constant(.placeholder), closeAction: {})
}
