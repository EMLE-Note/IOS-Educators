//
//  LibraryView.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 07/08/2024.
//

import SwiftUI
import EMLECore

struct LibraryView: View {
    @StateObject var viewModel: LibraryViewModel
    
    init(coordinator: LibraryViewCoordinating) {
        _viewModel = StateObject(wrappedValue: LibraryViewModel(coordinator: coordinator))
    }
    var body: some View {
        MainView(viewModel: viewModel) {
            SegmentedControl(selectedIndex: $viewModel.selectedTap, options: viewModel.options)
                .padding(.sm)
                .clipShape(Capsule())
            
            switch viewModel.libarayType {
            case .course:
                if !viewModel.coursesData.pageContent.isEmpty {
                    coursesBody
                }else {
                    Spacer()
                    emptyView
                    Spacer()
                }
            case .eBook:
                eBookView
            case .qBank:
                qBankBody
            case .drafts:
                draftView
            case .all:
                EmptyView()
            }
        }
        .customSheet(isPresented: $viewModel.isAddGroupViewPresented,
                     height: 300,
                     detents: [.medium],
                     content: { getSheetView { addNewGroupView() }
        })
        .customSheet(isPresented: $viewModel.isOptianQBankViewPresented,
                     height: 150,
                     detents: [.medium],
                     content: { getSheetView { optionalQBankView() }
        })
    }
}

#Preview {
    LibraryView(coordinator: LibarayViewCoordinator(navigationController: UINavigationController(), tabBarController: MainTabBarController()))
}

// MARK: - Course View -

extension LibraryView {
    private var coursesBody: some View {
        VStack {
            NoIndicatorsScrollView {
                PaginationView(direction: .vertical, canGetANewPage: viewModel.coursesData.canGetANewPage, getNewPageAction: viewModel.getNewCourses) {
                    
                    courseView
                        .customContentPadding(.horizontal, defaultHPadding)
                        .customContentPadding(.vertical, .md)
                        .redacted(viewModel.coursesLoadingState)
                        .withShimmerOverlay()
                }
            }
            
            HStack {
                PrimaryButton(title: LibraryStrings.addNewGroup.localized, action: viewModel.onAddNewGroupTapped)
                    .clipShape(Capsule())
                    .padding()
                
                PrimaryButton(title: LibraryStrings.addNewCourse.localized, action: viewModel.onAddNewCourseTapped)
                    .clipShape(Capsule())
                    .padding()
            }
            
        }
    }
    
    var courseView: some View {
        VStack {
            ForEach(viewModel.coursesData.pageContent, id: \.self) { cource in
                coursesCardView(course: cource)
                    .padding(.sm)
            }
            
            Spacer()
            
        }
    }
}

// MARK: - QBank View -

extension LibraryView {
    private var qBankBody: some View {
        VStack {
            NoIndicatorsScrollView {
                PaginationView(direction: .vertical, canGetANewPage: viewModel.qBank.canGetANewPage, getNewPageAction: viewModel.getNewQBank) {
                    
                    qBankView
                }
            }
            
            PrimaryButton(title: LibraryStrings.addNewQBank.localized, action: viewModel.addNewQBankTapped)
                .clipShape(Capsule())
                .padding()
        }
    }
    
    var qBankView: some View {
        VStack {
            ForEach(viewModel.qBank.pageContent, id: \.self) { qBank in
                qBankCardView(qBank: qBank)
                    .padding(.horizontal, .sm)
            }
            
            Spacer()
        }
    }
}

// MARK: - E-Book View -

extension LibraryView {
    var eBookView: some View {
        NoIndicatorsScrollView {
            ForEach(0...10, id: \.self) {_ in
                eBookCardView
                    .padding(.sm)
            }
        }
    }
}

// MARK: - Quizze View -

extension LibraryView {
    
}

// MARK: - Quizze View -

extension LibraryView {
    var draftView: some View {
        NoIndicatorsScrollView {
            ForEach(0...10, id: \.self) {_ in
                draftCardView
                    .padding(.sm)
            }
        }
    }
}

// MARK: - Course Card View -

extension LibraryView {
    private func coursesCardView(course: Course) -> some View {
        VStack(alignment: .leading, spacing: .xxSm) {
            VStack(alignment: .center) {
                CustomImageView(image: course.image, placeholder: Image.coursePlaceholder, contentMode: .fill)
                    .customCornerRadii(.xSm, corners: .allCorners)
                    .frame(height: 150)
            }
            .padding(.xSm)
            VStack(alignment: .leading,spacing: .xxSm){
                Text(course.name)
                    .customStyle(.subheadline, .onSurface)
                Text("\(course.foldersCount) \(LibraryStrings.folder.localized)")
                    .customStyle(.caption2, .subtitle)
            }
            .padding()
        }
        .withShimmerOverlay()
        .customBackground(.onPrimary)
        .withCardShadow(backgroundColor: .onSurface, cornerRadius: .sm)
        .onTapGesture {
            viewModel.onCardTapped(course.courseId)
        }
    }
    
    private func privacyView(privacyOptions:PrivacyOptions) -> some View {
        HStack(alignment: .center,spacing: .xxSm) {
            Image(systemName: privacyOptions.image)
                .frame(width: 10,height: 10)
            
            Text(privacyOptions.title)
        }
        .padding(.vertical,.xxSm)
        .padding(.horizontal,.xSm)
        .customForeground(.onPrimary)
        .customBackground(privacyOptions.backgroundColor)
        .customCornerRadii(.xxSm, corners: .allCorners)
    }
}

// MARK: - E-Book Card View -

extension LibraryView {
    private var eBookCardView: some View {
        VStack {
            
        }
    }
}

// MARK: - Quizze Card View -

extension LibraryView {
    private func qBankCardView(qBank: QBank) -> some View {
        HStack(alignment: .center, spacing: .xSm) {
            HStack(alignment: .center, spacing: .xSm) {
                VStack {
                    CustomImageView(image: qBank.image, placeholder: Image.coursePlaceholder, contentMode: .fill)
                        .customCornerRadii(.xxSm, corners: .allCorners)
                        .frame(width: 57, height: 57)
                }
                .padding(.xSm)

                VStack(alignment: .leading, spacing: .xSm) {
                    Text(qBank.name)
                        .customStyle(.subheadline, .onSurface)
                    Text("\(qBank.questionsCount) \(LibraryStrings.question.localized)")
                        .customStyle(.caption2, .subtitle)
                }
                .padding(.xxSm)

                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack(alignment: .center, spacing: .xSm) {
                
                Image.optianCourse
                    .resizable()
                    .frame(width: 16, height: 16)
                    .onTapGesture {
                        viewModel.onClickedOptianQBank(qbankId: qBank.qBankId)
                    }
            }
            .padding(.xSm)
        }
        .withShimmerOverlay()
        .customBackground(.onPrimary)
        .withCardShadow(backgroundColor: .onSurface, cornerRadius: 12)
    }
}

// MARK: - Draft Card View -

extension LibraryView {
    private var draftCardView: some View {
        VStack {
            
        }
    }
}


// MARK: - Empty Course View -

extension LibraryView {
    private var emptyView: some View {
        VStack(alignment: .center) {
            Image.emptyCourses
                .resizable()
                .frame(width: 240, height: 200)
            Text(LibraryStrings.youHaveNoCourses.localized)
                .customStyle(.heading1, .onSurface)
            PrimaryButton(title: LibraryStrings.createNewCourse.localized, action: viewModel.onAddNewCourseTapped)
                .clipShape(Capsule())
                .padding()
        }
    }
}

// MARK: - get Sheet View

extension LibraryView {
    private func getSheetView<Content: View>(@ViewBuilder content: @escaping () -> Content) -> some View {
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
    
    private func addNewGroupView() -> some View {
        VStack(alignment: .leading, spacing: .md) {
            HStack {
                Image.editQueation
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                
                Text(LibraryStrings.addNewGroup.localized)
                    .customStyle(.bodyMedium, .onSurface)
                Spacer()
            }
            .padding(.vertical, .sm)
            
            CustomTextField(title: LibraryStrings.groupName.localized,
                            placeholder: LibraryStrings.name.localized,
                            value: $viewModel.groupName,
                            borderStateColor: .neutral)
                .padding(.horizontal, .xxSm)
                .padding(.vertical, .xxSm)
            
            PrimaryButton(title: LibraryStrings.create.localized) { viewModel.onCreateNewGroupTapped() }
                .disabled(!viewModel.isCreateButtonEnabled)
                .clipShape(Capsule())
            
            Spacer()
        }
        .padding(.horizontal, .xSm)
        .customBackground(.container)
    }
}

// MARK: - QBank Sheet -

extension LibraryView {
    private func optionalQBankView() -> some View {
        VStack(alignment: .leading, spacing: .md) {
            ForEach(viewModel.qbankOptions, id: \.self) { option in
                optionView(for: option)
                    .onTapGesture {
                        viewModel.handleAction(for: option)
                    }
            }
        }
        .padding(.horizontal, .xSm)
        .customBackground(.container)
    }
    
    private func optionView(for option: QBankOptionType) -> some View {
        OptionView(
            icon: option.icon,
            title: option.title,
            description: option.description
        )
    }
}
