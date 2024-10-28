//
//  MonitorStatusService.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 04/10/2024.
//

import EMLECore
import Combine
import SwiftUI

class MonitorStatusService {
    
    @Inject var monitorStatus: MonitorServerResponseService
    @Inject var logoutUserUseCase: LogoutUserUseCase
    
    var cancellables: Set<AnyCancellable> = []

    init () {
        monitorStatus.$response.receive(on: DispatchQueue.main)
            .sink(receiveValue: handleResponse)
            .store(in: &cancellables)
    }
    
    func handleResponse (_ response: MonitorServerServiceResponse) {
        if response.statusCode == .monitorUnavailable  {
            logoutUserUseCase.execute()
        }
    }
}

extension StatusCode {
    static let monitorUnavailable = StatusCode(402)
}
