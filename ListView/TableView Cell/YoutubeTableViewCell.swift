//
//  YoutubeTableViewCell.swift
//  ListView
//
//  Created by Ravi Kishore on 9/21/19.
//  Copyright © 2019 ThinkAnts. All rights reserved.
//

import UIKit

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
}
