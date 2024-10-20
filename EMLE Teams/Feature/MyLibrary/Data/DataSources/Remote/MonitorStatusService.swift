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
    
    var cancellables: Set<AnyCancellable> = []

    init () {
        monitorStatus.$response.receive(on: DispatchQueue.main)
            .sink(receiveValue: handleResponse)
            .store(in: &cancellables)
    }
    
    func handleResponse (_ response: MonitorServerServiceResponse) {
        if response.statusCode == .monitorUnavailable  {
            
        }
        
        print("Status Code", response.statusCode)
    }
}

extension StatusCode {
    static let monitorUnavailable = StatusCode(402)
}
