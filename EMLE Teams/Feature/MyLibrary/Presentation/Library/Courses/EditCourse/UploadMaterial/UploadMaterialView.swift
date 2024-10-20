//
//  UploadMaterialViewModel.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 05/10/2024.
//

import SwiftUI
import EMLECore

struct UploadMaterialView: View {
    
    @StateObject var viewModel: UploadMaterialViewModel
    
    init(folderId: Int, coordinator: UploadMaterialCoordinating) {
        _viewModel = StateObject(wrappedValue: UploadMaterialViewModel(folderId: folderId, coordinator: coordinator))
    }
    
    @State private var offset: CGFloat = 1000
    
    var body: some View {
        ZStack {
            Color.black.opacity(viewModel.isPresented ? 0.4 : 0)
                .animation(.easeInOut, value: viewModel.isPresented)
                .onTapGesture {
                    viewModel.close()
                }
            
            VStack {
                HStack {
                    ForEach(UploadMaterialType.allCases, id: \.self) { option in
                        CustomRadioButton(
                            title: option.rawValue,
                            isSelected: viewModel.selectedUploadMaterial == option,
                            action: {
                                viewModel.selectedUploadMaterial = option
                            }
                        )
                        if option == UploadMaterialType.allCases.first {
                            Spacer()
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.xSm)
                
                if viewModel.selectedUploadMaterial == .emleServer {
                    PrimaryButton(title: LibraryStrings.selectVideo.localized, action: {
                        viewModel.selectedVideoTapped()
                    })
                } else {
                    
                    CustomTextField(
                        title: LibraryStrings.videoName.localized,
                        placeholder: LibraryStrings.videoName.localized,
                        value: $viewModel.videoName,
                        borderStateColor: .neutral
                    )
                    .padding(.top, .xSm)
                    .padding(.bottom, .xSm)
                    
                    ForEach(VideoType.allCases, id: \.self) { option in
                        VStack(alignment: .leading) {
                            let isDisabled = option == .publitio
                            let borderColor: ColorStyle = isDisabled ? .neutral : .primary
                            
                            if viewModel.selectedUploadType == option {
                                PrimaryButton(
                                    title: "\(option.localizedDescription)",
                                    action: {
                                        viewModel.performActionFor(option: option)
                                    },
                                    leadingIcon: option.icon
                                )
                            } else {
                                OutlinedButton(
                                    title: "\(option.rawValue)",
                                    action: {
                                        viewModel.selectedUploadType = option
                                    },
                                    leadingIcon: option.icon,
                                    borderColor: borderColor
                                )
                                .disabled(isDisabled)
                            }
                            
                            if viewModel.selectedUploadType == option {
                                CustomTextField(
                                    title: nil,
                                    placeholder: LibraryStrings.pasteVideoLink.localized,
                                    value: $viewModel.link,
                                    borderStateColor: .neutral
                                )
                                .padding(.top, .xSm)
                            }
                        }
                        .padding(.bottom, .sm)
                    }
                    
                    PrimaryButton(title: LibraryStrings.upload.localized, action: {
                        viewModel.uploadTapped()
                    })
                    .disabled(!viewModel.isUploadButtonEnabled)
                    .clipShape(Capsule())
                }
            }
            .fixedSize(horizontal: false, vertical: true)
            .padding()
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(radius: 20)
            .padding(30)
            .offset(y: viewModel.isPresented ? 0 : 1000)
            .animation(.spring(), value: viewModel.isPresented)
        }
        .ignoresSafeArea()
        .onAppear {
            viewModel.toggleVisibility()
        }
    }
    
}

#Preview {
    UploadMaterialView(folderId: -1, coordinator: UploadMaterialCoordinator(navigationController: UINavigationController(), tabBarController: MainTabBarController()))
}
