//
//  CustomDailogTextFieldView.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 14/08/2024.
//

import SwiftUI
import EMLECore

struct CustomDailogTextFieldView: View {
    
    @StateObject var viewModel: CustomDailogTextFieldViewModel
    @FocusState var isMinTextFieldFocused: Bool
    
    init(coordinator: CustomDailogTextFieldViewCoordinator, model: CustomDialogTextFieldModel) {
        _viewModel = StateObject(wrappedValue: CustomDailogTextFieldViewModel(coordinator: coordinator, model: model))
    }
    
    var body: some View {
        ZStack {
            Color(.black)
                .opacity(0.4)
                .onTapGesture {
                    viewModel.cancelTapped()
                }

            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                    Text(viewModel.model.title)
                        .customStyle(.heading2, .onSurface)
                    Spacer()
                }
                
                Text("Folder name")
                    .customStyle(.subheadline, .onSurface)
                
                
                textField(placeholder: "Enter folder name",
                          value: $viewModel.folderName,
                          isFocused: $isMinTextFieldFocused)

                
                PrimaryButton(title: viewModel.model.buttonTitle) {
                    viewModel.performAction()
                }
                .disabled(!viewModel.isCreateFolderButtonEnabled)
                .clipShape(Capsule())
                
                TextButton(title: "Cancel",
                               action: { viewModel.cancelTapped() },
                               cornerRadius: .xBig,
                               textColor: .subtitle)
            }
            .fixedSize(horizontal: false, vertical: true)
            .padding()
            .customBackground(.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .padding(.xxxBig)
            .offset(y: viewModel.isActive ? 0 : UIScreen.main.bounds.height)
            .onAppear {
                withAnimation(.spring()) {
                    viewModel.isActive = true
                }
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    CustomDailogTextFieldView(coordinator: CustomDailogTextFieldViewCoordinator(navigationController: UINavigationController(), tabBarController: MainTabBarController()), model: .placeholder)
}

extension CustomDailogTextFieldView {
    @ViewBuilder
    private func textField(placeholder: String, value: Binding<String>, isFocused: FocusState<Bool>.Binding) -> some View {
        TextField(placeholder, text: value)
            .keyboardType(.numberPad)
            .focused(isFocused)
            .padding()
            .cornerRadius(.xSm)
            .overlay(
                RoundedRectangle(cornerRadius: .xSm)
                    .stroke(isFocused.wrappedValue ? Color.primaryColor : Color.neutral, lineWidth: 2)
                    .scaleEffect(isFocused.wrappedValue ? 1.02 : 1)
                    .animation(.easeOut(duration: 0.2), value: isFocused.wrappedValue)
            )
    }
}
