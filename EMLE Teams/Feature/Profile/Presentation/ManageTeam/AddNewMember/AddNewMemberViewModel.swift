//
//  ManageTeamViewModel.swift
//  EMLE Teams
//
//  Created by iOSAYed on 05/09/2024.
//

import Foundation
import EMLECore
import CountryPicker
import Combine

typealias DisplayedTeamPermissionsData = [String: [(Int, String)]]

class AddNewMemberViewModel: MainViewModel {
    var coordinator: AddNewMemberCoordinating
    var cancellables = Set<AnyCancellable>()

    init(coordinator: AddNewMemberCoordinating) {
        self.coordinator = coordinator
    }
    var isTabBarVisible: Bool { false }
    
    @Inject var getTeamPermissionsUseCase: TeamPermissionsUseCase
    
    @Published var phoneNumber: String = ""
    @Published var selectedCountry: String = ""
    @Published var country = Country(isoCode: "EG")
    @Published var user: User = .dummy
    @Published var selectedInstractorOption: InstructorOptions = .instructor
    @Published var  selectedOptionType: TeamPermissionOptions = .contents
    
    @Published var teamPermissionsData: TeamPermissions = .placeholder
    @Published var isFullAccessGranted: Bool = false
    @Published var isPresentingCountryCodePicker: Bool = false
    @Published var isPresentingCoursePermission: Bool = false
    @Published var getTeamPermissionsLoadingState: LoadingState = .loaded
}

extension AddNewMemberViewModel {
    func onAppear() {
        getTeamPermissions()
        configureCountryCode()
    }
    
    func countryCodeClick() {
        isPresentingCountryCodePicker = true
    }
    
    func setCountryCode(country: Country) {
        
        self.country = country
        
        isPresentingCountryCodePicker = false
        
        setCountryPhoneCode()
        
    }
    
    func searchOnMember(){
        print("Search")
    }
    
    func teamPermissions() -> DisplayedTeamPermissionsData{
        switch selectedOptionType {
        case .contents:
           return extractPermissionsData(from: teamPermissionsData, optionType: .contents)
        case .enrollments:
            return extractPermissionsData(from: teamPermissionsData, optionType: .enrollments)
        case .finances:
            return extractPermissionsData(from: teamPermissionsData, optionType: .finances)
        case .managements:
            return extractPermissionsData(from: teamPermissionsData, optionType: .managements)
        }
    }
}

extension AddNewMemberViewModel {
    private func configureCountryCode() {
        
        if let countryCode = (Locale.current as NSLocale).object(forKey: .countryCode) as? String {
            
            country = Country(isoCode: countryCode)
            setCountryPhoneCode()
        }
        
    }
    
    private func setCountryPhoneCode() {
        
        selectedCountry = RegistrationStrings.phoneCodeSS.localizedFormat(arguments: country.isoCode.getFlag(), "+\(country.phoneCode)")
    }
    
    private func extractPermissionsData(from teamPermissions: TeamPermissions, optionType:TeamPermissionOptions) -> DisplayedTeamPermissionsData {
        let contents = teamPermissions.permissions.contents
        let enrollments = teamPermissions.permissions.enrollments
        let finances = teamPermissions.permissions.finances
        let managements = teamPermissions.permissions.managements
        
        return createPermissionsDictionary(contents: contents,enrollments:enrollments ,finances: finances, managements: managements,optionType:optionType)
    }

    private func createPermissionsDictionary(contents: PermissionContent,enrollments:PermissionContent, finances: [PermissionItem], managements: [PermissionItem],optionType:TeamPermissionOptions) -> DisplayedTeamPermissionsData  {
        var permissionsData: DisplayedTeamPermissionsData = [:]
        
        switch optionType {
        case .contents:
            permissionsData["Courses"] = convertToTupleArray(items: contents.courses)
            permissionsData["Ebooks"] = convertToTupleArray(items: contents.ebooks)
            permissionsData["Quizzes"] = convertToTupleArray(items: contents.quizzes)
        case .enrollments:
            permissionsData["Courses"] = convertToTupleArray(items: enrollments.courses)
            permissionsData["Ebooks"] = convertToTupleArray(items: enrollments.ebooks)
            permissionsData["Quizzes"] = convertToTupleArray(items: enrollments.quizzes)
        case .finances:
            permissionsData[optionType.title] = convertToTupleArray(items: finances)
        case .managements:
            permissionsData[optionType.title] = convertToTupleArray(items: managements)
        }
        
        return permissionsData
    }

    private func convertToTupleArray(items: [PermissionItem]) -> [(Int, String)] {
        return items.map { ($0.id, $0.name) }
    }


}


// MARK: TeamPermissions

extension AddNewMemberViewModel {
    
    func getTeamPermissions() {
        getTeamPermissionsLoadingState = .loading
        
        do {
            try getTeamPermissionsUseCase.execute()
                .sink(receiveCompletion: handleGetTeamPermissionsCompletion, receiveValue: handleGetTeamPermissionsResult)
                .store(in: &cancellables)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func handleGetTeamPermissionsCompletion(completion: Subscribers.Completion<UseCaseError>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print("Error: \(error)")
            getTeamPermissionsLoadingState = .failed
        }
    }
    
    func handleGetTeamPermissionsResult(result: DomainWrapper<TeamPermissions>) {
        getTeamPermissionsLoadingState = .loaded
        
        if result.isSuccess, let teamPermissions = result.data {
            teamPermissionsData = teamPermissions
        } else {
            print(result.message)
            showToast(message: result.message)
        }
    }
}

