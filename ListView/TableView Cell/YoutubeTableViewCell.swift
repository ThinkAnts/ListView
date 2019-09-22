//
//  YoutubeTableViewCell.swift
//  ListView
//
//  Created by Ravi Kishore on 9/21/19.
//  Copyright © 2019 ThinkAnts. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class YoutubeTableViewCell: UITableViewCell {

    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var playerView: PlayerView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        userImageView.layer.cornerRadius = userImageView.frame.size.width / 2;
        userImageView.clipsToBounds = true;
        playerView.backgroundColor = UIColor.black
    }
    
    func setup() {
        titleLabel.text = "Big Buck Bunndy Video"
        guard let videoUrl = URL(string:"https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4") else { return }
        let avPlayer = AVPlayer(url: videoUrl)
        playerView?.playerLayer.frame = self.frame
        playerView?.playerLayer.player = avPlayer
    }
}
