//
//  ListViewModel.swift
//  ListView
//
//  Created by Ravi on 18/09/19.
//  Copyright © 2019 ThinkAnts. All rights reserved.
//

import Foundation

protocol ListViewModelDelegate: class {
    func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?)
    func onFetchFailed(with reason: String)
}

final class ListViewModel {
    private weak var delegate: ListViewModelDelegate?
    private let networking = Networking()
    private var currentPage = 1
    private var total = 0
    private var isFetchInProgress = false
    private var moderators: [Moderator] = []

    init(delegate: ListViewModelDelegate) {
        self.delegate = delegate
    }
    
//    var totalCount: Int {
//        return total
//    }

    var totalCount: Box<Int> = Box(0)
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
            switch response {
            case .failure(let error):
                DispatchQueue.main.async {
                self.isFetchInProgress = false
                self.delegate?.onFetchFailed(with: error.reason)
                }
            case .success(let response):
                DispatchQueue.main.async {
                    self.currentPage += 1
                    self.isFetchInProgress = false
                    //self.total = response.total
                    self.totalCount.value = response.total
                    self.moderators.append(contentsOf: response.moderators)
                    if response.page > 1 {
                        let indexPathsToReload = self.calculateIndexPathsToReload(from: response.moderators)
                        self.delegate?.onFetchCompleted(with: indexPathsToReload)
                    } else {
                        self.delegate?.onFetchCompleted(with: .none)
                    }
                }
            }
            completion?()
        }
    }

    private func prepareRequestParams() -> ModeratorParams {
        var params = ModeratorParams()
        params.pageCount = String(currentPage)
        params.site = "StackOverflow"
        return params
    }

    private func calculateIndexPathsToReload(from newModerators: [Moderator]) -> [IndexPath] {
        let startIndex = moderators.count - newModerators.count
        let endIndex = startIndex + newModerators.count
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
}
