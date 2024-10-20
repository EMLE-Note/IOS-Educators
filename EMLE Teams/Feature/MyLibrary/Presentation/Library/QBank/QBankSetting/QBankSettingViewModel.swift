//
//  QBankSettingViewModel.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 25/09/2024.
//

import Foundation
import EMLECore
import SwiftUI
import Combine

class QBankSettingViewModel: MainViewModel {
    let coordinator: QBankSettingCoordinating
    let qbankId: Int
    
    init(coordinator: QBankSettingCoordinating, qbankId: Int) {
        self.coordinator = coordinator
        self.qbankId = qbankId
    }
    
    @Published var qbankData: QBank?
    
    @Published var rawCoursePrice: String = ""
    @Published var qbankPrice: String = ""
    @Published var qbankID = ""
    @Published var qbankTitle = ""
    @Published var qbankOverview = ""
    @Published var imagePickerPresenting = false
    @Published var qbankLoadingState: LoadingState = .loaded
    @Published var qbankImage: ImagePickerImage = .empty {
        didSet {
            didSelectImage = true
        }
    }
    
    var isTabBarVisible: Bool { false }
    var sourceType: ImagePickerSourceType = .photos
    var didSelectImage = false
    var cancellables = Set<AnyCancellable>()
    
    var isApplyButtonEnabled: Bool {
        !qbankTitle.isEmpty && !qbankPrice.isEmpty && !qbankOverview.isEmpty
    }
    
    @Inject var getQBankSettingUseCase: GetQBankSettingUseCase
    @Inject var updateQBankSettingUseCase: UpdateQBankSettingUseCase
    
}

extension QBankSettingViewModel {
    func onAppear() {
        fetchQBankSetting(qbankId: qbankId)
    }
    
    func updateCoursePrice(_ newValue: String) {
        var validPrice = newValue.filter { "0123456789".contains($0) }
        
        while validPrice.hasPrefix("0") && validPrice.count > 1 {
            validPrice.removeFirst()
        }
        
        if validPrice == "0" {
            validPrice = ""
        }
        
        if validPrice != rawCoursePrice {
            DispatchQueue.main.async {
                self.rawCoursePrice = validPrice
            }
        }
    }
    
    func onChangeImageClick() {
        sourceType = .photos
        imagePickerPresenting = true
    }
    
    func onApplyChangeClick() {
        updateQBank(qbankId: qbankId)
    }
    
    func onDiscardChangeClick() {
        
    }
}

// MARK: - get Content requests -

extension QBankSettingViewModel {
    func fetchQBankSetting(qbankId: Int) {
        do {
            let params = GetQBankSettingParameter(qbankId: qbankId, filters: .empty)
            
            try getQBankSettingUseCase.execute(params: params)
                .sink(receiveCompletion: handleSecretriesCompletion,
                      receiveValue: handleContentRequestsResult)
                .store(in: &cancellables)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func handleSecretriesCompletion(completion: Subscribers.Completion<UseCaseError>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print("Error: \(error)")
            showErrorToast(error: error)
            qbankLoadingState = .failed
        }
    }
    
    private func handleContentRequestsResult(result: DomainWrapper<QBank>) {
        qbankLoadingState = .loaded
        
        if result.isSuccess {
            self.qbankData = result.data
            if let qbankID = qbankData?.uuid, let qbankTitle = qbankData?.name, let qbankPrice = qbankData?.price, let currency = qbankData?.currency, let qbankOverview = qbankData?.overview {
                self.qbankID = qbankID
                self.qbankTitle = qbankTitle
                self.qbankPrice = "\(qbankPrice) \(currency)"
                self.qbankOverview = qbankOverview
            }
            
        } else {
            print(result.message)
            showErrorToast(message: result.message)
        }
    }
}

// MARK: - Update Course -

extension QBankSettingViewModel {
    func updateQBank(qbankId: Int) {
        do {
            let updateCourse = UpdateQBankSettingFormDataRequest(title: qbankTitle, image: didSelectImage ? qbankImage.imageData : nil, overview: qbankOverview, price: Double(qbankPrice))
            let body = UpdateQBankSettingParameter(qbankId: qbankId, data: updateCourse)

            try updateQBankSettingUseCase.execute(params: body)
                .sink(receiveCompletion: handleSecretriesCompletion,
                      receiveValue: handleRequestsResult)
                .store(in: &cancellables)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func handleRequestsResult(result: DomainWrapper<UpdateQBankSettingResponse>) {
        qbankLoadingState = .loaded
        
        if result.isSuccess {
            showSuccessToast(message: result.message)
            coordinator.popView()
        } else {
            print(result.message)
            showErrorToast(message: result.message)
        }
    }
}
