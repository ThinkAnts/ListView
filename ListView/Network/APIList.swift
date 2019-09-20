//
//  APIList.swift
//  ListView
//
//  Created by Ravi on 18/09/19.
//  Copyright © 2019 ThinkAnts. All rights reserved.
//

import Foundation

enum APIList {
    case allModerators(moderators: ModeratorParams)
}

extension APIList: Endpoint {
    var baseURL: URL {
        return URL(string: "http://api.stackexchange.com/2.2/")!
    }
    
    var path: String {
        switch self {
        case .allModerators( _):
            return "users/moderators"
        }
    }
    
    var paramters: [String: String]? {
        switch self {
        case .allModerators(let params):
            return ["order": params.order, "sort": params.sort, "filter": params.filter, "page": params.pageCount, "site": params.site]
        }
    }
}
