//
//  FinanceViewModel.swift
//  EMLE Teams
//
//  Created by iOSAYed on 28/06/2024.
//

import Combine
import EMLECore

final class FinanceViewModel: MainViewModel {
    let coordinator: FinanceViewCoordinating
    @Inject var getFinanceDataUseCase: FinanceDataUseCase
    var cancellables = Set<AnyCancellable>()
    
    init(coordinator: FinanceViewCoordinating) {
        self.coordinator = coordinator
    }
    
    var billState: BillStates = .active
    
    var alertMessage: String {
        let progress = getProgressRate(balanceUsed: balanceUsed)
        if progress >= 0.7 {
            return "Your bill capacity is reaching the limit, consider paying your bill as soon as possible."
        } else if progress == 1 {
            return "Your bill capacity has reached the limit and your account is suspended. Pay your bill to restore account services."
        } else {
            return ""
        }
    }
    
    @Published var isBalanceRechargeViewPresented = false
    @Published var getFinanceLoadingState: LoadingState = .loaded
    @Published var balance: Double = 0.0
    @Published var balanceUsed: Double = 4000
    @Published var bills: Bills = .placeholder
    @Published var currancy: Currency = .placeholder
    @Published var currentBill: Bill = .placeholder
    @Published var wallet: Double = 0.0
    @Published var depits: Double = 0.0
    @Published var noDataMessage:String = ""
    
    
}

//MARK: Functions
extension FinanceViewModel {
    func onAppear() {
        getFinanceData()
    }
    
    func getProgressRate(balanceUsed: Double) -> Double {
        let totalBalance: Double = 5000
        guard balanceUsed <= totalBalance else { return 0.0 }
        return balanceUsed / totalBalance
    }
    
    func onClickedOnWallet() {
        coordinator.goToExternalWallet()
    }
    func onClickedOnEnrollment() {
        coordinator.goToEnrollment()
    }
    
}

// MARK: Get Finanace Data

extension FinanceViewModel {
    func onClickedOnBalance() {
        withOptionalAnimation {
            isBalanceRechargeViewPresented = true
        }
    }
    
    func onClickedOnPaymentHistory() {
        print("Payment History")
    }
    
    func onClickedOnPayNow() {
        let dataFromFinance = DataPassedToCheckout(billId: currentBill.id ?? 0, currency: currancy, balance: balance, totalToPay: bills.total ?? 0.0)
        coordinator.goToCheckout(dataFromFinance: dataFromFinance)
    }

    func onClickedOnBillCard() {
        coordinator.goToBillPaymentDetails(currentBills: bills)
    }
    
    func rechargeBalanceOnClicked() {
        print("rechargeBalanceOnClicked")
    }

   
}

//MARK: Finance API CALL
extension FinanceViewModel {
    
    func getFinanceData() {
        getFinanceLoadingState = .loading
        
        do {
            try getFinanceDataUseCase.execute()
                .sink(receiveCompletion: handleGetFinanceCompletion, receiveValue: handleFinanceDataResult)
                .store(in: &cancellables)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func handleGetFinanceCompletion(completion: Subscribers.Completion<UseCaseError>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print("Error: \(error)")
            noDataMessage = FinanceStrings.noDataAppear.localized
            getFinanceLoadingState = .failed
        }
    }
    
    func handleFinanceDataResult(result: DomainWrapper<Finance>) {
        getFinanceLoadingState = .loaded    
        
        if result.isSuccess, let financeData = result.data {
            balance = financeData.balance ?? 0.0
            balanceUsed = financeData.currentDeal?.capacity?.toTwoDecimalDigit() ?? 0.0
            billState = financeData.bills?.current?.billState ?? .overDue
            wallet = financeData.externalWallet ?? 0.0
            depits = financeData.debts ?? 0.0
            
            if let bill = financeData.bills?.current, let currentCurrancy = financeData.currentDeal?.currency,let bills = financeData.bills {
                currentBill = bill
                currancy = currentCurrancy
                self.bills = bills
                SharedData.shared.currancy = currentCurrancy
            }
            
        } else {
            print(result.message)
            noDataMessage = result.message
            showToast(message: result.message)
        }
    }
}
