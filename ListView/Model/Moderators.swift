//
//  Moderators.swift
//  ListView
//
//  Created by Ravi Kishore on 9/19/19.
//  Copyright © 2019 ThinkAnts. All rights reserved.
//

import Foundation

struct Moderators: Codable {
    let moderators: [Moderator]
    let total: Int
    let hasMore: Bool
    let page: Int

    private enum CodingKeys: String, CodingKey {
        case moderators = "items"
        case hasMore = "has_more"
        case total
        case page
    }
}
