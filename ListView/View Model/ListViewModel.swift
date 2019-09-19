//
//  ListViewModel.swift
//  ListView
//
//  Created by Ravi on 18/09/19.
//  Copyright © 2019 ThinkAnts. All rights reserved.
//

import Foundation

class ListViewModel {
    private let networking = Networking()
    
    public func fetchModerators(completion: (() -> Void)?) {
        networking.performNetworkTask(endpoint: APIList.allModerators(moderators: prepareRequestParams()), type: Moderators.self, method: "", params: nil) { (response) in
            print(response)
            completion?()
        }
    }
    
    private func prepareRequestParams() -> ModeratorParams {
        var params = ModeratorParams()
        params.pageCount = 1
        params.site = "Stack Overflow"
        return params
    }
}
