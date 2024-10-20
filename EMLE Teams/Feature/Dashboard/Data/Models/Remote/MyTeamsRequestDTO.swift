//
//  MyTeamsRequestDTO.swift
//  EMLE Teams
//
//  Created by iOSAYed on 27/09/2024.
//

import Foundation
import EMLECore

class MyTeamsRequestDTO: CustomRequest {
    var endPoint: APIEndPoint { .getMyTeams }
    var method: RequestMethod { .get }
}
