//
//  CousesDetailsView.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 08/08/2024.
//

import SwiftUI
import EMLECore

struct CourseDetailsView: View {
    @Namespace private var namespace
    @Namespace private var searchBarId
    
    @StateObject var viewModel: CourseDetailsViewModel
    
    init(courseId: Int, coordinator: CourseDetailsViewCoordinating) {
        _viewModel = StateObject(wrappedValue: CourseDetailsViewModel(courseId: courseId, coordinator: coordinator))
    }
    
    var body: some View {
        MainView(viewModel: viewModel) {
            navigationBar
            SegmentedControl(selectedIndex: $viewModel.selectedTap, options: viewModel.options)
                .padding(.sm)
                .clipShape(Capsule())
            
            switch viewModel.courseContentType {
            case .content: 
                if !viewModel.isShowContentEmptyView {
                    contentView
                } else {
                    emptyContentView
                }
            case .student:
                if !viewModel.isShowEmptyView {
                    studentBody
                } else {
                    emptyStudenView
                }
            case .all:     EmptyView()
            }
        }
        .customSheet(isPresented: $viewModel.isOptianContentViewPresented,
                     height: 150,
                    detents: [.medium],
                     content: { getSheetView { optionalContentView() }
        })
        .customSheet(isPresented: $viewModel.isOptianStudentViewPresented,
                     height: 150,
                     detents: [.medium],
                     content: { getSheetView { optionalStudentView() }
        })
        .customSheet(isPresented: $viewModel.isFilterStudentViewPresented,
                     height: 450,
                     detents: [.medium],
                     content: { getSheetView { fillterView() }
        })
        .withCustomDialog(
            isPresented: $viewModel.isDeactivateDialogViewPresented,
            image: .placeholder,
            title: viewModel.dialogModel.title,
            message: viewModel.dialogModel.title,
            yesButtonTitle: viewModel.dialogModel.title,
            yesButtonAction: viewModel.deactivateTapped,
            noButtonTitle: viewModel.dialogModel.title
        )
        .withCustomDialog(
            isPresented: $viewModel.isDeleteDialogViewPresented,
            image: .placeholder,
            title: viewModel.dialogDeleteFolderModel.title,
            message: viewModel.dialogDeleteFolderModel.title,
            yesButtonTitle: viewModel.dialogDeleteFolderModel.title,
            yesButtonAction: viewModel.deleteFolder,
            noButtonTitle: viewModel.dialogDeleteFolderModel.title
        )
        .withCustomDialog(
            isPresented: $viewModel.isDeactivateAllDialogViewPresented,
            image: .placeholder,
            title: viewModel.dialogDeactivateAllModel.title,
            message: viewModel.dialogDeactivateAllModel.title,
            yesButtonTitle: viewModel.dialogDeactivateAllModel.title,
            yesButtonAction: viewModel.deactivateAllTapped,
            noButtonTitle: viewModel.dialogDeactivateAllModel.title
        )
    }
}

#Preview {
    CourseDetailsView(courseId: -1, coordinator: CourseDetailsViewCoordinator(navigationController: UINavigationController(), tabBarController: MainTabBarController()))
}

// MARK: - Content Body View

extension CourseDetailsView {
    private var contentView: some View {
        VStack {
            if let folders = viewModel.contents?.folders {
                NoIndicatorsScrollView {
                    ForEach(folders, id: \.id) { folder in
                        contentCardView(course: folder)
                            .padding(.xxSm)
                    }
                }
                Spacer()
                
                if viewModel.isParentFolder {
                    parentButton
                } else {
                    lessonButton
                }
            } else {
                Spacer()
                emptyContentView
                Spacer()
            }
        }
    }
}

// MARK: - Strudent Body View

extension CourseDetailsView {
    
    private var studentBody: some View {
        PaginationView(canGetANewPage: viewModel.students.canGetANewPage, getNewPageAction: viewModel.getNewStudents) {
            studentsView
        }
    }
    
    private var studentsView: some View {
        VStack(alignment: .leading) {
            searchBarView
            
            Text("\(viewModel.students.pageContent.count) \(LibraryStrings.students.localized)")
                .customStyle(.bodySmall, .onSurface)
                .padding(.horizontal)
            
            NoIndicatorsScrollView {
                ForEach(viewModel.students.pageContent, id: \.self) { student in
                    studentCardView(student: student)
                        .padding(.xxSm)
                }
            }
            Spacer()
        }
    }
}

// MARK: - Navigation View -

extension CourseDetailsView {
    private var navigationBar: some View {
        HStack {
            CustomNavigationBar.Checkout(title: viewModel.contents?.name ?? "")
                .padding(.bottom, .xSm)
                .customBackground(.container)
                .padding(.horizontal, defaultHPadding)
            
            Spacer()
            
            if viewModel.selectedTap == 1 {
                if viewModel.isAllDeactivated {
                    PrimaryButton(title: viewModel.buttonTitle,
                                  action: viewModel.deactivateAllTapped,
                                  height: 30,
                                  cornerRadius: .xxSm,
                                  backgroundColor: .success)
                    
                    .padding(.horizontal, .md)
                } else {
                    CancelButton(title: viewModel.buttonTitle,
                                 action: viewModel.deactivateAllTapped,
                                 height: 30,
                                 cornerRadius: .xxSm)
                    .padding(.horizontal, .md)
                }
            } else {
                Image.edit
                    .resizable()
                    .frame(width: 28, height: 28)
                    .padding(.horizontal, .md)
                    .padding(.bottom, .xSm)
                    .onTapGesture {
                        viewModel.editCourseTapped()
                    }
            }
        }
        .customBackground(.container)
    }
}

// MARK: - Content View -

extension CourseDetailsView {
    private func contentCardView(course: Folder) -> some View {
        HStack(alignment: .center, spacing: .xSm) {
            HStack(alignment: .center, spacing: .xSm) {
                VStack {
                    Image.folderIcon
                        .customCornerRadii(.xxSm, corners: .allCorners)
                        .frame(width: 57, height: 57)
                }
                .padding(.xSm)

                VStack(alignment: .leading, spacing: .xSm) {
                    Text(course.name)
                        .customStyle(.subheadline, .onSurface)
                    Text("\(course.foldersCount) \(LibraryStrings.folder.localized)")
                        .customStyle(.caption2, .subtitle)
                }
                .padding(.xxSm)

                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack(alignment: .center, spacing: .xSm) {
                privacyView(isPublic: course.isVisible)
                
                Image.optianCourse
                    .resizable()
                    .frame(width: 16, height: 16)
                    .onTapGesture {
                        viewModel.onClickedOptianContent(folderId: course.folderId, isVisible: course.isVisible)
                    }
            }
            .padding(.xSm)
        }
        .redacted(viewModel.contentLoadingState)
        .withShimmerOverlay()
        .customBackground(.onPrimary)
        .withCardShadow(backgroundColor: .onSurface, cornerRadius: 12)
        .padding(.horizontal, .xSm)
        .onTapGesture {
            viewModel.onClickedShowChildernFolder(folderId: course.folderId)
        }
    }
    
    private func privacyView(isPublic: Bool) -> some View {
        Group {
            if !isPublic {
                Image.eyeOff
                    .resizable()
                    .frame(width: 30, height: 30)
            } else {
                EmptyView()
            }
        }
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

// MARK: - Student Card View -

extension CourseDetailsView {
    private func studentCardView(student: EnrollmentStudent) -> some View {
        HStack(alignment: .center, spacing: .xSm) {
            HStack(alignment: .center, spacing: .xSm) {
                VStack {
                    CustomImageView(image: student.student.image, placeholder: .emptyCourses, contentMode: .fill)
                        .clipShape(Capsule())
                        .frame(width: 40, height: 40)
                }
                .padding(.xSm)

                VStack(alignment: .leading, spacing: .xSm) {
                    Text(student.student.name)
                        .customStyle(.subheadline, .onSurface)
                    Text(student.student.mobile)
                        .customStyle(.bodySmall, .subtitle)
                    Text(viewModel.getDuration(to: student.expireAt ?? "") ?? "")
                        .customStyle(.caption1, .secondary)
                }
                .padding(.xxSm)

                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Image.optianCourse
                .resizable()
                .frame(width: 16, height: 16)
                .padding(.xSm)
                .onTapGesture {
                    viewModel.onClickedOptianStudent(enrollmentId: student.enrollmentId, isActive: student.status == 1, security: student.security)
                }
        }
        .redacted(viewModel.studentLoadingState)
        .withShimmerOverlay()
        .customBackground(.onPrimary)
        .withCardShadow(backgroundColor: .onSurface, cornerRadius: .sm)
        .withCardBorder(bordered: student.status == 2,
                        borderColor: .error)
        .padding(.horizontal, .xSm)
    }

    
    private var searchBarView: some View {
        VStack(spacing: 16) {
            HStack(spacing: 12) {
                studentSearchBar
                filtersButton
            }
        }
        .padding(.horizontal, defaultHPadding)
    }
    
    private var studentSearchBar: some View {
        SearchBar(searchText: $viewModel.searchText)
            .matchedGeometryEffect(id: searchBarId, in: namespace)
            .frame(height: 50)
            .background {
                RoundedRectangle(cornerRadius: .xSm)
                    .customStroke(.neutral)
            }
    }
    
    private var filtersButton: some View {
        PrimaryImageButton(image: .filters,
                           action: viewModel.onFiltersClicked)
    }
}

// MARK: - Empty Content View -

extension CourseDetailsView {
    private var emptyContentView: some View {
        VStack(alignment: .center, spacing: .xSm) {
            Image.emptyContent
                .resizable()
                .frame(width: 160, height: 170)
            Text(LibraryStrings.startBuildingCourse.localized)
                .customStyle(.heading1, .onSurface)
            
            VStack(alignment: .center, spacing: .xSm) {
                parentButton
                lessonButton
            }
        }
        .padding()
    }
}

// MARK: - Empty Student View -

extension CourseDetailsView {
    private var emptyStudenView: some View {
        VStack(alignment: .center, spacing: .xSm) {
            Spacer()
            Image.emptyStudent
                .resizable()
                .frame(width: 160, height: 170)
            Text(LibraryStrings.youDontHaveStudent.localized)
                .customStyle(.heading2, .onSurface)
            Spacer()
        }
    }
}

// MARK: - Optional View -

extension CourseDetailsView {
    private func optionalContentView() -> some View {
        VStack(alignment: .leading, spacing: .md) {
            ForEach(viewModel.contentOptions, id: \.self) { option in
                optionView(for: option)
                    .onTapGesture {
                        viewModel.handleAction(for: option)
                    }
            }
        }
        .padding(.horizontal, .xSm)
        .customBackground(.container)
    }
    
    private func optionalStudentView() -> some View {
        VStack(alignment: .leading, spacing: .md) {
            ForEach(viewModel.studentOptions, id: \.self) { option in
                optionView(for: option)
                    .onTapGesture {
                        viewModel.handleAction(for: option)
                    }
            }
        }
        .padding(.horizontal, .xSm)
        .customBackground(.container)
    }
    
    private func optionView(for option: OptionType) -> some View {
        OptionView(
            icon: option.icon,
            title: option.title,
            description: option.description
        )
    }
}

// MARK: - Fillter View -

extension CourseDetailsView {
    private var divider: some View {
        VStack {
            Divider()
        }
        .padding(.vertical, .md)
    }
    
    private func fillterView() -> some View {
        VStack(alignment: .leading, spacing: .md) {
            HStack(alignment: .center) {
                Spacer()
                Text(LibraryStrings.filter.localized)
                    .customStyle(.headline, .onSurface)
                Spacer()
            }
            .padding(.vertical, .sm)
            
            sortByDate
            filterStatusTypeView
            customButtons
            
            Spacer()
        }
        .customBackground(.container)
    }
    
    private var sortByDate: some View {
        VStack(alignment: .leading, spacing: .xSm) {
            Text(LibraryStrings.sortBy.localized)
                .customStyle(.subheadline, .onSurface)
            
            ForEach(FilterStudentOptions.allCases, id: \.self) { option in
                CustomRadioButton(
                    title: option.localizedDescription,
                    isSelected: viewModel.selectedDateOption == option,
                    action: {
                        viewModel.selectedDateOption = option
                    }
                )
            }
            divider
        }
    }
    
    private var filterStatusTypeView: some View {
        VStack(alignment: .leading) {
            Text(LibraryStrings.status.localized)
                .customStyle(.subheadline, .onSurface)
            ForEach(FilterStatusTypeOptions.allCases, id: \.self) { type in
                CustomCheckbox(
                    title: type.localizedDescription,
                    isChecked: .constant(viewModel.selectedStatusTypes.contains(type)),
                    action: {}
                )
            }
        }
    }
    
    private var customButtons: some View {
        VStack {
            PrimaryButton(title: LibraryStrings.applyChanges.localized) { viewModel.onApplyChangeClick() }
                .clipShape(Capsule())
            
            TextButton(title: LibraryStrings.discardChanges.localized,
                       action: { viewModel.onDiscardChangeClick() },
                       textColor: .subtitle)
            
            
        }
        .padding(.vertical, .xSm)
    }
}

// MARK: - Parent Button -

extension CourseDetailsView {
    private var parentButton: some View {
        PrimaryButton(title: LibraryStrings.createParentFolder.localized, action: viewModel.onClickedCreateParentFolder)
            .clipShape(Capsule())
            .padding()
    }
}

extension CourseDetailsView {
    private var lessonButton: some View {
        PrimaryButton(title: LibraryStrings.createLessonFolder.localized,
                      action: viewModel.onClickedCreateLessonFolder,
                      textColor: .onSurface,
                      backgroundColor: .onPrimary)
        .clipShape(Capsule())
        .padding(.xxSm)
    }
}
