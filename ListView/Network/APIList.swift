//
//  APIList.swift
//  ListView
//
//  Created by Ravi on 18/09/19.
//  Copyright © 2019 ThinkAnts. All rights reserved.
//

import Foundation

enum APIList {
    case allContacts(contacts: String)
}

extension APIList: Endpoint {
    var baseURL: URL {
        return URL(string: "http://gojek-contacts-app.herokuapp.com")!
    }
    
    var path: String {
        switch self {
        case .allContacts(let contacts):
            return "/\(contacts).json"
        }
    }
}
