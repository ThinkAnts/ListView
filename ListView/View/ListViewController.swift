//
//  ListViewController.swift
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

class ListViewController: UIViewController, DisplayAlert {
    private enum CellIdentifiers {
        static let list = "List"
    }
    var reachability: Reachability!
    private var listViewModel: ListViewModel!
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
                        //self.view.layoutIfNeeded()
                    }
                }
            default:
                self.activityIndicator.startAnimating()
                self.activityLabel.text = state == .loadingLocal ? "Loading data from cache" : "Downloading data from server"
                UIView.animate(withDuration: 0.50) {
                    self.tableViewTopSpaceConstraint.constant = 60.0
                    //self.view.layoutIfNeeded()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.reachability = Reachability()
        self.state = .loadingLocal
        listViewModel = ListViewModel(delegate: self)
        fetchModerators()
    }
    
    func fetchModerators() {
        listViewModel.fetchModerators {
            DispatchQueue.main.async {
                self.state = .inactive
            }
        }
    }
}

extension ListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listViewModel.totalCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.list, for: indexPath) as! ListViewCell
        if isLoadingCell(for: indexPath) {
            cell.configure(with: .none)
        } else {
            cell.configure(with: listViewModel.moderator(at: indexPath.row))
        }
        return cell
    }
}

private extension ListViewController {
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= listViewModel.currentCount
    }
    
    func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
        let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows ?? []
        let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
        return Array(indexPathsIntersection)
    }
}

extension ListViewController: ListViewModelDelegate {
    func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?) {
        // 1
        guard let newIndexPathsToReload = newIndexPathsToReload else {
            //indicatorView.stopAnimating()
            tableView.isHidden = false
            tableView.reloadData()
            return
        }
        let indexPathsToReload = visibleIndexPathsToReload(intersecting: newIndexPathsToReload)
        tableView.reloadRows(at: indexPathsToReload, with: .automatic)
    }
    
    func onFetchFailed(with reason: String) {
        //indicatorView.stopAnimating()
        let title = "Warning".localizedString
        let action = UIAlertAction(title: "OK".localizedString, style: .default)
        displayAlert(with: title , message: reason, actions: [action])
    }
}
