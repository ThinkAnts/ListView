//
//  Response.swift
//  ListView
//
//  Created by Ravi on 18/09/19.
//  Copyright © 2019 ThinkAnts. All rights reserved.
//

import Foundation

struct Response {
    fileprivate var data: Data
    init(data: Data) {
        self.data = data
    }
}

extension Response {
    public func decode<T: Codable>(_ type: T.Type) -> T? {
        do {
            let jsonDecoder = JSONDecoder()
                let response = try jsonDecoder.decode(T.self, from: data)
                return response
        } catch {
            print(error)
        }
        return nil
    }
}
