//
//  PlayerView.swift
//  ListView
//
//  Created by Ravi Kishore on 9/22/19.
//  Copyright © 2019 ThinkAnts. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class PlayerView: UIView {

    override static var layerClass: AnyClass {
        return AVPlayerLayer.self
    }
    
    var playerLayer: AVPlayerLayer {
        return layer as! AVPlayerLayer
    }
    
    var player: AVPlayer? {
        get {
            return playerLayer.player
        }
        set {
            playerLayer.player = newValue
        }
    }

}
