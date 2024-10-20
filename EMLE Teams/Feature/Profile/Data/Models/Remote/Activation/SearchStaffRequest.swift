//
//  SearchStaffRequest.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 14/10/2024.
//

import Foundation
import EMLECore

class SearchStaffRequest: CustomRequest {
    
    var endPoint: APIEndPoint { .searchStaff }
    
    var url: String { String(format: MainCloudConfig.apiUrl + endPoint.value) }
    
    var method: RequestMethod { .post }
    
    var dto: RequestDTO? { _dto }

    private let _dto: SearchStaffDTO
    
    init(data: SearchStaff) {
        _dto = SearchStaffDTO(mobile_code: data.mobileCode, mobile: data.mobile)
    }
}
