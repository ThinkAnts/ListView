//
//  ListViewCell.swift
//  ListView
//
//  Created by Ravi Kishore on 9/20/19.
//  Copyright © 2019 ThinkAnts. All rights reserved.
//

import UIKit

class ListViewCell: UITableViewCell {

    @IBOutlet var displayNameLabel: UILabel!
    @IBOutlet var reputationLabel: UILabel!
   // @IBOutlet var reputationContainerView: UIView!
    //@IBOutlet var indicatorView: UIActivityIndicatorView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        configure(with: .none)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with moderator: Moderator?) {
        if let moderator = moderator {
            displayNameLabel?.text = moderator.displayName
            reputationLabel?.text = moderator.reputation
            displayNameLabel.alpha = 1
        } else {
            displayNameLabel.alpha = 0
        }
    }

}
