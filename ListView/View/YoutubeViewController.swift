//
//  YoutubeViewController.swift
//  ListView
//
//  Created by Ravi Kishore on 9/21/19.
//  Copyright © 2019 ThinkAnts. All rights reserved.
//

import UIKit


class YoutubeViewController: UIViewController {

    private enum CellIdentifiers {
        static let youtube = "Youtube"
    }
    @IBOutlet weak var youtubeTableView: UITableView!
    private var youtubeViewModel: YoutubeModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        self.title = "Youtube".localizedString
        youtubeTableView.register(UINib.init(nibName: "YoutubeTableViewCell", bundle: Bundle.main),
                                  forCellReuseIdentifier: CellIdentifiers.youtube)
        youtubeViewModel = YoutubeModel(delegate: self)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension YoutubeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return youtubeViewModel.totalCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.youtube, for: indexPath) as? YoutubeTableViewCell else {
            return UITableViewCell()
        }
        cell.setup()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300.0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let videoCell = (cell as? YoutubeTableViewCell) else { return }
          let visibleCells = tableView.visibleCells
          let minIndex = visibleCells.startIndex
          if tableView.indexPathsForVisibleRows?.first?.row == minIndex {
             videoCell.playerView.player?.play()
             videoCell.playerView.player?.isMuted = true
         }
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let videoCell = cell as? YoutubeTableViewCell else { return }
        videoCell.playerView.player?.pause()
        videoCell.playerView.player = nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        youtubeViewModel.showVideoView()
    }
    
}

extension YoutubeViewController: YoutubeModelDelegate {
    func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?) {
    }
    
    func onFetchFailed(with reason: String) {
    }
}
