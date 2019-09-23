//
//  VideoLauncher.swift
//  ListView
//
//  Created by Ravi Kishore on 9/22/19.
//  Copyright © 2019 ThinkAnts. All rights reserved.
//

import Foundation
import UIKit

class VideoLauncher: NSObject {
    private var mainView: UIView!
    func showVideoPlayer() {
        if let keyWindow = UIApplication.shared.keyWindow {
            mainView = UIView(frame: keyWindow.frame)
            mainView.backgroundColor = UIColor.white
            
            // 16 X 9 is aspect ratio of all HD Videos
            let height = keyWindow.frame.width * 9 / 16
            let videoPlayerFrame = CGRect(x: 0, y: 0, width: keyWindow.frame.size.width, height: height)
            let videoPlayerView = VideoPlayerView(frame: videoPlayerFrame)
            mainView.addSubview(videoPlayerView)
            mainView.frame = CGRect(x: keyWindow.frame.width - 10, y: keyWindow.frame.height - 10, width: 10, height: 10)
            keyWindow.addSubview(mainView)
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut,
                          animations: {
                            self.mainView.frame = keyWindow.frame
            }) { (completedAnimation) in
                guard let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as? UIView else { return }
                statusBar.isHidden = true
                videoPlayerView.updateFavourite = { 
                    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut,
                                   animations: {
                                    videoPlayerView.frame.size.height = 100
                                    videoPlayerView.frame.size.width = keyWindow.frame.size.width
                                    self.mainView.frame = CGRect(x: 0, y: keyWindow.frame.height - 150, width: keyWindow.frame.size.width, height: 50)
                    }) { (completedAnimation) in
                        guard let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as? UIView else { return }
                        statusBar.isHidden = true
                    }
                }
                }
            }
        }
}
