//
//  ActivationView.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 11/10/2024.
//

import SwiftUI
import EMLECore

struct ActivationView: View {

    
    @StateObject var viewModel: ActivationViewModel
    
    
    init(coordinator: ActivationCoordinating) {
        _viewModel = StateObject(wrappedValue: ActivationViewModel(coordinator: coordinator))
    }

    var body: some View {
        MainView(viewModel: viewModel) {
            navigationBar
            
            activationLearnerButton
            
            activationRequestText
            
            activationView
            Spacer()
        }
    }
}

#Preview {
    ActivationView(coordinator: ActivationCoordinator(navigationController: UINavigationController(), tabBarController: MainTabBarController()))
}

// MARK: - Navigation View -

extension ActivationView {
    private var navigationBar: some View {
        HStack {
            CustomNavigationBar.Checkout(title: MoreStrings.activation.localized)
                .padding(.bottom, .xSm)
                .padding(.horizontal, defaultHPadding)
            
            Spacer()
            
            OutlinedButton(title: MoreStrings.approveAll.localized, action: {
                viewModel.approveAllTapped()
            }, height: 30, cornerRadius: 15)
            .padding(.sm)
        }
    }
}

// MARK: - Activation Learner -

extension ActivationView {
    private var activationLearnerButton: some View {
        PrimaryButton(title: MoreStrings.activateNewLearner.localized, action: {
            viewModel.activateNewLearnerTapped()
        })
        .clipShape(Capsule())
        .padding()
        
    }
}

// MARK: - Activation Request -

extension ActivationView {
    private var activationRequestText: some View {
        VStack(alignment: .leading) {
            Text(MoreStrings.activaionRequest.localized)
                .customStyle(.headline, .onSurface)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

// MARK: - E-Book View -

extension ActivationView {
    var activationView: some View {
        ListView(
            dataArray: viewModel.activationData,
            noDataImage: Image.activationEmpty,
            noDataMessage: MoreStrings.youDonotHaveAnyRequest.localized,
            noDataSubMessage: MoreStrings.whenLearnersSendActivityRequest.localized
        ) {
            NoIndicatorsScrollView {
                ForEach(viewModel.activationData.indices, id: \.self) { index in
                    activationCardView(activationData: viewModel.activationData[index], index: index)
                        .padding(.horizontal, .sm)
                }
            }
        }
    }
}

// MARK: - Course Card View -

extension ActivationView {
    private func activationCardView(activationData: Activations, index: Int) -> some View {
        VStack(alignment: .leading, spacing: .xxSm) {
            HStack(alignment: .center, spacing: .xSm) {
                CustomImageView(image: activationData.student.image, placeholder: Image.coursePlaceholder, contentMode: .fill)
                    .clipShape(Capsule())
                    .frame(width: 36, height: 36)
                    .padding(.xSm)
                
                VStack(alignment: .leading, spacing: .xSm) {
                    Text(activationData.student.name)
                        .customStyle(.subheadline, .onSurface)
                    Text(activationData.createdAt)
                        .customStyle(.caption1, .subtitle)
                }
                .padding(.xxSm)
                
                Spacer()
                
                CustomCheckBox(isOn: Binding(
                    get: { viewModel.isSelected(index: index) },
                    set: { value in
                        viewModel.setSelected(value, index: index)
                    }
                ), title: "")
            }
            
            detailsView(title: MoreStrings.registrationId.localized, value: "\(activationData.registrationID)")
            detailsView(title: MoreStrings.mobileNumber.localized, value: activationData.student.mobile)
            detailsView(title: MoreStrings.name.localized, value: activationData.registrationName)
            detailsView(title: MoreStrings.MaterialType.localized, value: activationData.type)
            detailsView(title: MoreStrings.materialName.localized, value: activationData.requestable.name)
            detailsView(title: MoreStrings.paidAmount.localized, value: "\(activationData.paidAmount)")
            
            buttons(index: index)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .withShimmerOverlay()
        .customBackground(viewModel.isSelected(index: index) ? .primaryOpacity(opacity: 0.7) : .onPrimary)
        .withCardShadow(backgroundColor: .onSurface, cornerRadius: .sm)
    }

    private func detailsView(title: String, value: String) -> some View {
        HStack {
            Text(title)
                .customStyle(.bodySmall, .onSurface)
            
            Spacer()
            
            Text(value)
                .customStyle(.subheadline, .secondary)
        }
        .padding(.vertical, .xSm)
    }
    
    private func buttons(index: Int) -> some View {
        HStack {
            OutlinedButton(title: MoreStrings.decline.localized, action: {
                viewModel.rejectTapped(at: index)
            }, height: 30, cornerRadius: 15)
            .frame(maxWidth: 110)
            
            PrimaryButton(title: MoreStrings.approve.localized, action: {
                viewModel.approveTapped(at: index)
            }, height: 30)
            .withCardShadow()
            .clipShape(Capsule())
            
        }
    }
}
