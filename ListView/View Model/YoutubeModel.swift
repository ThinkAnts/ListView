//
//  YoutubeModel.swift
//  ListView
//
//  Created by Ravi Kishore on 9/22/19.
//  Copyright © 2019 ThinkAnts. All rights reserved.
//

import Foundation

protocol YoutubeModelDelegate: class {
    func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?)
    func onFetchFailed(with reason: String)
}

final class YoutubeModel {
    private var total = 5
    private weak var delegate: YoutubeModelDelegate?

    var totalCount: Int {
        return total
    }

    init(delegate: YoutubeModelDelegate) {
        self.delegate = delegate
    }
    
    func showVideoView() {
        let videoLauncher = VideoLauncher()
        videoLauncher.showVideoPlayer()
    }
}
