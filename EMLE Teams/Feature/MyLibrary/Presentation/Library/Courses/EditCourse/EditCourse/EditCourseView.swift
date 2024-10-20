//
//  EditCourseView.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 10/08/2024.
//

import SwiftUI
import EMLECore

struct EditCourseView: View {
    
    @StateObject var viewModel: EditCourseViewModel
    
    init(courseId: Int, coordinator: EditCourseViewCoordinating) {
        _viewModel = StateObject(wrappedValue: EditCourseViewModel(courseId: courseId, coordinator: coordinator))
    }
    
    var body: some View {
        MainView(viewModel: viewModel) {
            navigationBar
            
            editView
            
            toggleView
            
            Spacer()
        }
        .withCustomDialog(
            isPresented: $viewModel.isDeactivateCourseDialogViewPresented,
            image: .placeholder,
            title: viewModel.dialogDeactivateCourseModel.title,
            message: viewModel.dialogDeactivateCourseModel.title,
            yesButtonTitle: viewModel.dialogDeactivateCourseModel.title,
            yesButtonAction: viewModel.onClickedDeactivateCourse,
            noButtonTitle: viewModel.dialogDeactivateCourseModel.title
        )
        .withCustomDialog(
            isPresented: $viewModel.isDeleteCourseDialogViewPresented,
            image: .placeholder,
            title: viewModel.dialogDeleteCourseModel.title,
            message: viewModel.dialogDeleteCourseModel.title,
            yesButtonTitle: viewModel.dialogDeleteCourseModel.title,
            yesButtonAction: viewModel.onClickedDeleteCourse,
            noButtonTitle: viewModel.dialogDeleteCourseModel.title
        )
    }
}

// Preview for SwiftUI View
struct EditCourseView_Previews: PreviewProvider {
    static var previews: some View {
        EditCourseView(courseId: -1, coordinator: EditCourseViewCoordinator(navigationController: UINavigationController(), tabBarController: MainTabBarController()))
    }
}

extension EditCourseView {
    private var navigationBar: some View {
        HStack {
            CustomNavigationBar.Checkout(title: LibraryStrings.editCourse.localized)
                .padding(.bottom, .xxSm)
                .customBackground(.container)
                .padding(.horizontal, defaultHPadding)
            
            Spacer()

            
            Button(action: {
                viewModel.deleteCourseTapped()
            }) {
                Text(LibraryStrings.delete.localized)
                    .customFont(.subheadline)
            }
            .padding(.horizontal, .md)
            .padding(.vertical, .xSm)
            .customBackground(.white)
            .customForeground(.error)
            .customCornerRadii(.xxSm, corners: .allCorners)
            .overlay(
                RoundedRectangle(cornerRadius: .xxSm)
                    .stroke(Color.red, lineWidth: 1)
            )
            .padding(.horizontal, .md)
        }
        .customBackground(.container)
        .padding(.bottom, .xxSm)
    }
}

extension EditCourseView {
    private var editView: some View {
        VStack {
            EditView(title: LibraryStrings.courseSetting.localized, action: { viewModel.courseSetingTapped() })
            EditView(title: LibraryStrings.targetLearner.localized, action: { viewModel.targetedLearnersTapped() })
            EditView(title: LibraryStrings.protectionLayer.localized, action: { viewModel.protectionLayersTapped() })
            EditView(title: LibraryStrings.visibility.localized, action: { viewModel.visibilityTapped() })
        }
        .padding()
    }
}

extension EditCourseView {
    private var toggleView: some View {
        VStack {
            if let _ = viewModel.isCourseActive {
                ToggleView(isOn: $viewModel.isCourseActive.unwrapped(),
                           title: viewModel.isCourseActive == true ? LibraryStrings.activateCourse.localized : LibraryStrings.deactivateCourse.localized,
                           action: { viewModel.deactivateCourseTapped() },
                           tint: .error)
            }

            if let _ = viewModel.allowOfflineWatching {
                ToggleView(isOn: $viewModel.allowOfflineWatching.unwrapped(),
                           title: LibraryStrings.allowOfflineWatching.localized,
                           action: {
                    viewModel.allowOfflineWatchingTapped()
                })
            }

            Spacer()
        }
        .padding(.horizontal, .xSm)
    }
    
    
}
extension Binding where Value == Bool? {
    func unwrapped(defaultValue: Bool = false) -> Binding<Bool> {
        return Binding<Bool>(
            get: { self.wrappedValue ?? defaultValue },
            set: { newValue in self.wrappedValue = newValue }
        )
    }
}
