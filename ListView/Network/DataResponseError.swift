//
//  DataResponseError.swift
//  ListView
//
//  Created by Ravi Kishore on 9/19/19.
//  Copyright © 2019 ThinkAnts. All rights reserved.
//

import Foundation

enum DataResponseError: Error {
    case network
    case decoding
    
    var reason: String {
        switch self {
        case .network:
            return "An error occurred while fetching data".localizedString
        case .decoding:
            return "An error occurred while decoding data".localizedString
        }
    }
}
