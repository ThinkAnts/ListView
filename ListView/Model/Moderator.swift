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
        case reputation 
    }

    init(displayName: String, reputation: String) {
        self.displayName = displayName
        self.reputation = reputation
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let displayName = try container.decode(String.self, forKey: .displayName)
        let reputation = try container.decode(Double.self, forKey: .reputation)
        self.init(displayName: displayName.html2String, reputation: reputation.formatted)
    }
}

struct ModeratorParams {
    var order = "desc"
    var sort = "reputation"
    var filter = "!-*jbN0CeyJHb"
    var pageCount = ""
    var site = ""
}
