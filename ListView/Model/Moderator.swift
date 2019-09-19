//
//  Moderator.swift
//  ListView
//
//  Created by Ravi Kishore on 9/19/19.
//  Copyright © 2019 ThinkAnts. All rights reserved.
//

import Foundation

struct Moderator: Codable {
    let displayName: String?
    let reputation: String?
    
    private enum CodingKeys: String, CodingKey {
        case displayName = "display_name"
        case reputation = "reputation"
    }
}

struct ModeratorParams {
    var order = "desc"
    var sort = "reputation"
    var filter = "!-*jbN0CeyJHb"
    var pageCount = 0
    var site = ""
}
