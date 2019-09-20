//
//  Double+Extensions.swift
//  ListView
//
//  Created by Ravi Kishore on 9/19/19.
//  Copyright © 2019 ThinkAnts. All rights reserved.
//

import Foundation

extension Double {
    static let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.decimal
        return formatter
    }()
    
    var formatted: String {
        return Double.formatter.string(for: self) ?? String(self)
    }
}
