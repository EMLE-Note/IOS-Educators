//
//  CheckoutViewModel.swift
//  EMLE Teams
//
//  Created by iOSAYed on 08/07/2024.
//

import Combine
import EMLECore

final class CheckoutViewModel: MainViewModel {
    let coordinator: CheckoutViewCoordinating
    @Inject var getPaymentMethodsUseCase: GetPaymentMethodsUseCase
    @Inject var getwayBillsPaymentUseCase: GetwayBillsPaymentUseCase
    var cancellables = Set<AnyCancellable>()
    
    let dataFromFinance: DataPassedToCheckout
    
    @Published var getPaymentMethodsLoadingState: LoadingState = .loaded
    @Published var payByGetwayLoadingState: LoadingState = .loaded
    @Published var payByMyBalanceLoadingState: LoadingState = .loaded
    @Published var paymentMethods: [PaymentMethod] = []
    @Published var paymenId: Int = 0
    @Published var paymentCallBackResult: PaymentCallBackType? = .unknown
    
    init(dataFromFinance: DataPassedToCheckout, coordinator: CheckoutViewCoordinating) {
        self.dataFromFinance = dataFromFinance
        self.coordinator = coordinator
    }

    var isTabBarVisible: Bool {
        false
    }
    
    var totalToPay: String {
        return dataFromFinance.totalToPay.stringTwoDecimalDigit
            + " " + (dataFromFinance.currency.code ?? "")
    }
    
    var myBalance: String {
        return dataFromFinance.balance.stringTwoDecimalDigit
            + " " + (dataFromFinance.currency.code ?? "")
    }
}

// MARK: Functions

extension CheckoutViewModel {
    func onAppear() {
        getPaymentMethods()
    }
    
    func ProceedToPayClicked() {
        print("Proceed")
        PayByGetwayPayment()
    }
    
    private func setupGetwayPaymentParameters() -> GetwayBillsPaymentParameter {
        return GetwayBillsPaymentParameter(
            teamBillId: dataFromFinance.billId,
            paymentMethodId: paymenId
        )
    }
    
    private func goToPaymentView(url: String) {
        coordinator.goToPaymentView(url: url)
    }
}

// MARK: - Get Payment Methods

extension CheckoutViewModel {
    func getPaymentMethods() {
        getPaymentMethodsLoadingState = .loading
        
        do {
            guard let currancyId = dataFromFinance.currency.id else { return }
            try getPaymentMethodsUseCase.execute(with: currancyId)
                .sink(receiveCompletion: handleGetPaymentMethodsCompletion, receiveValue: handlePaymentMethodsResult)
                .store(in: &cancellables)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func handleGetPaymentMethodsCompletion(completion: Subscribers.Completion<UseCaseError>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print("Error: \(error)")
            getPaymentMethodsLoadingState = .failed
        }
    }
    
    func handlePaymentMethodsResult(result: DomainWrapper<[PaymentMethod]>) {
        getPaymentMethodsLoadingState = .loaded
        
        if result.isSuccess, let paymentMethods = result.data {
            print(paymentMethods)
            let myBalanceMethod = PaymentMethod(id: -1, name: "My Balance", image: "dollar-img", displayName: "My Balance", currency: .dummy)
            self.paymentMethods = paymentMethods
            self.paymentMethods.append(myBalanceMethod)
        } else {
            print(result.message)
            //            showErrorToast(message: result.message)
        }
    }
}

// MARK: Payment

extension CheckoutViewModel {
    func PayByGetwayPayment() {
        payByGetwayLoadingState = .loading
        
        do {
            try getwayBillsPaymentUseCase.execute(teamId: "35", params: setupGetwayPaymentParameters())
                .sink(receiveCompletion: handlePayByGetwayCompletion, receiveValue: handlePayByGetwayResult)
                .store(in: &cancellables)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func handlePayByGetwayCompletion(completion: Subscribers.Completion<UseCaseError>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print("Error: \(error)")
            payByGetwayLoadingState = .failed
        }
    }
    
    func handlePayByGetwayResult(result: DomainWrapper<BillsPayment>) {
        payByGetwayLoadingState = .loaded
        
        if result.isSuccess, let paymentData = result.data {
            goToPaymentView(url: paymentData.paymentURL)
        } else {
            print(result.message)
            //            showErrorToast(message: result.message)
        }
    }
}
