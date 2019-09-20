//
//  Result.swift
//  ListView
//
//  Created by Ravi Kishore on 9/19/19.
//  Copyright © 2019 ThinkAnts. All rights reserved.
//

import Foundation

enum Result<T, U: Error> {
    case success(T)
    case failure(U)
}
