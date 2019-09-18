//
//  ViewController.swift
//  ListView
//
//  Created by Ravi on 18/09/19.
//  Copyright © 2019 ThinkAnts. All rights reserved.
//

import UIKit
import Reachability

enum ActivityState {
    case inactive
    case loadingLocal
    case loadingRemote
}

class ViewController: UIViewController {

    var reachability: Reachability!

    @IBOutlet weak var tableViewTopSpaceConstraint: NSLayoutConstraint!
    @IBOutlet weak var activityLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!

    var state: ActivityState = .inactive {
        didSet {
            switch state {
            case .inactive:
                self.activityIndicator.stopAnimating()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    self.activityLabel.text = ""
                    UIView.animate(withDuration: 0.50) {
                        self.tableViewTopSpaceConstraint.constant = 0.0
                        self.view.layoutIfNeeded()
                    }
                }
            default:
                self.activityIndicator.startAnimating()
                self.activityLabel.text = state == .loadingLocal ? "Loading data from cache" : "Downloading data from server"
                UIView.animate(withDuration: 0.50) {
                    self.tableViewTopSpaceConstraint.constant = 60.0
                    self.view.layoutIfNeeded()
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.reachability = Reachability()
        self.state = .loadingLocal
    }

}
