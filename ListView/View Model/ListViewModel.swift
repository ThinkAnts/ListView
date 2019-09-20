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
    private var currentPage = 1
    private var total = 0
    private var isFetchInProgress = false
    private var moderators: [Moderator] = []

    var totalCount: Int {
        return total
    }

    var currentCount: Int {
        return moderators.count
    }

    func moderator(at index: Int) -> Moderator {
        return moderators[index]
    }

    public func fetchModerators(completion: (() -> Void)?) {
        guard !isFetchInProgress else {
            return
        }
        isFetchInProgress = true
        networking.performNetworkTask(endpoint: APIList.allModerators(moderators: prepareRequestParams()), type: Moderators.self, method: "", params: nil) { response in
            print(response)
            switch response {
            // 3
            case .failure(let error):
                    self.isFetchInProgress = false
            case .success(let response):
                    self.currentPage += 1
                    self.isFetchInProgress = false
                    self.total = response.total
                    self.moderators.append(contentsOf: response.moderators)
//                    
//                    // 3
//                    if response.page > 1 {
//                        let indexPathsToReload = self.calculateIndexPathsToReload(from: response.moderators)
//                        self.delegate?.onFetchCompleted(with: indexPathsToReload)
//                    } else {
//                        self.delegate?.onFetchCompleted(with: .none)
//                    }
            }

            completion?()
        }
    }
    
    private func prepareRequestParams() -> ModeratorParams {
        var params = ModeratorParams()
        params.pageCount = "1"
        params.site = "StackOverflow"
        return params
    }
}
