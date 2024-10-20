//
//  CourseSettingView.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 12/08/2024.
//

import SwiftUI
import EMLECore

struct CourseSettingView: View {
    @StateObject var viewModel: CourseSettingViewModel
    
    init(courseId: Int,coordinator: CourseSettingViewCoordinating) {
        _viewModel = StateObject(wrappedValue: CourseSettingViewModel(courseId: courseId, coordinator: coordinator))
    }
    
    var body: some View {
        navigationBar
        MainView(viewModel: viewModel) {
            NoIndicatorsScrollView {
                changeImageView
                courseIdView
                courseTitleView
                coursePriceView
                courseOverView
                expirationDate
                groupView
                Spacer()
            }
            customButtons
        }
        .sheet(isPresented: $viewModel.imagePickerPresenting, content: {
            ImagePicker(pickerImage: $viewModel.courseImage, sourceType: viewModel.sourceType)
        })
        .customSheet(isPresented: $viewModel.isPresentCustomSheetView,
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

#Preview {
    CourseSettingView(courseId: -1, coordinator: CourseSettingViewCoordinator(navigationController: UINavigationController(), tabBarController: MainTabBarController()))
}

// MARK: - Navigation View -

extension CourseSettingView {
    private var navigationBar: some View {
        HStack {
            CustomNavigationBar.Checkout(title: LibraryStrings.courseSetting.localized)
                .padding(.bottom, .xxSm)
                .customBackground(.container)
                .padding(.horizontal, defaultHPadding)
        }
    }
}

// MARK: - Change Image -

extension CourseSettingView {
    private var changeImageView: some View {
        VStack(alignment: .leading) {
            Text(LibraryStrings.courseImage.localized)
                .customStyle(.subheadline, .onSurface)
            
            Group {
                if viewModel.didSelectImage {
                    Image(uiImage: viewModel.courseImage.image)
                        .customCornerRadii(.xSm, corners: .allCorners)
                        .frame(width: 350, height: 150)
                        .customBackground(.onSurface)
                        .opacity(0.5)
                        .overlay(alignment: .center) {
                            Text(LibraryStrings.changeImage.localized)
                                .customStyle(.subheadline, .onPrimary)
                        }
                        .customCornerRadii(.xSm, corners: .allCorners)
                        .onTapGesture {
                            viewModel.onChangeImageClick()
                        }
                } else {
                    CustomImageView(image: viewModel.courseData?.image,
                                    placeholder: Image.coursePlaceholder,
                                    contentMode: .fill)
                    .customCornerRadii(.xSm, corners: .allCorners)
                    .frame(width: 350, height: 150)
                    .customBackground(.onSurface)
                    .opacity(0.5)
                    .overlay(alignment: .center) {
                        Text(LibraryStrings.changeImage.localized)
                            .customStyle(.subheadline, .onPrimary)
                    }
                    .customCornerRadii(.xSm, corners: .allCorners)
                    .onTapGesture {
                        viewModel.onChangeImageClick()
                    }
                }
            }
            
            Text(LibraryStrings.maximumPicSize.localized)
                .customStyle(.caption1, .subtitle)
        }
    }
}

// MARK: - Course ID -

extension CourseSettingView {
    private var courseIdView: some View {
        VStack(alignment: .leading) {
            CustomTextField(title: LibraryStrings.courseId.localized,
                            placeholder: LibraryStrings.courseIdPH.localized,
                            value: $viewModel.courseDataId,
                            borderStateColor: .neutral,
                            disable: true)
            .opacity(0.7)
            .padding(.horizontal, .md)
        }
    }
}

// MARK: - Course Title -

extension CourseSettingView {
    private var courseTitleView: some View {
        VStack(alignment: .leading) {
            CustomTextField(title: LibraryStrings.courseTitle.localized,
                            placeholder: LibraryStrings.courseTitlePH.localized,
                            value: $viewModel.courseTitle,
                            borderStateColor: .neutral)
            .padding(.horizontal, .md)
            .padding(.vertical, .md)
        }
    }
}

// MARK: - Course Price -

extension CourseSettingView {
    private var coursePriceView: some View {
        VStack(alignment: .leading) {
            CustomTextField(title: LibraryStrings.price.localized,
                            placeholder: LibraryStrings.coursePricePH.localized,
                            value: $viewModel.coursePrice,
                            borderStateColor: .neutral)
            .keyboardType(.numberPad)
            .padding(.horizontal, .md)
        }
    }
}

// MARK: - Course OverView -

extension CourseSettingView {
    private var courseOverView: some View {
        VStack(alignment: .leading) {
            Text(LibraryStrings.courseOverview.localized)
                .customStyle(.subheadline, .onSurface)
            
            CustomTextView(text: $viewModel.courseOverview,
                           placeholder: LibraryStrings.courseOverviewPH.localized)
        }
        .padding(.horizontal, .md)
        .padding(.vertical, .md)
    }
}

// MARK: - Course Date -

extension CourseSettingView {
    private var expirationDate: some View {
        VStack(alignment: .leading) {
            Text(LibraryStrings.expirtationDur.localized)
                .customStyle(.subheadline, .onSurface)
            
            HStack {
                Image.calendar
                    .resizable()
                    .frame(width: 28, height: 28)
                    .padding()
                
                TextField(LibraryStrings.courseExpirationDatePH.localized, text: $viewModel.duration)
                    .customStyle(.subheadline, .onSurface)
                    .padding(.vertical, .xxSm)
            }
            .customBackground(.onPrimary)
            .withCardBorder(backgroundColor: .onPrimary, cornerRadius: .xSm, borderColor: .neutral)
        }
        .padding(.horizontal, .md)
        .padding(.vertical, .md)
    }
}

// MARK: - Groups -

extension CourseSettingView {
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

extension CourseSettingView {
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

// MARK: - Apply Button -

extension CourseSettingView {
    private var customButtons: some View {
        VStack {
            PrimaryButton(title: LibraryStrings.applyChanges.localized) { viewModel.onApplyChangeClick() }
                .disabled(!viewModel.isApplyButtonEnabled)
                .clipShape(Capsule())
            
            TextButton(title: LibraryStrings.discardChanges.localized) { viewModel.onDiscardChangeClick() }
            
            
        }
        .padding(.horizontal, .md)
    }
}
