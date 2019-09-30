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
    var videoLauncher = VideoLauncher()
    var panGesture = UIPanGestureRecognizer()
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        self.title = "Youtube".localizedString
        youtubeTableView.register(UINib.init(nibName: "YoutubeTableViewCell", bundle: Bundle.main),
                                  forCellReuseIdentifier: CellIdentifiers.youtube)
        youtubeViewModel = YoutubeModel(delegate: self)
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.draggedView(_:)))
        videoLauncher.mainView.isUserInteractionEnabled = true
        videoLauncher.mainView.addGestureRecognizer(panGesture)
    }

    @objc func draggedView(_ sender:UIPanGestureRecognizer){
        self.view.bringSubviewToFront(videoLauncher.mainView)
        let translation = sender.translation(in: self.view)
        videoLauncher.mainView.center = CGPoint(x: videoLauncher.mainView.center.x + translation.x, y: videoLauncher.mainView.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: self.view)
    }

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
        //youtubeViewModel.showVideoView()
        videoLauncher.showVideoPlayer()

    }
    
}

extension YoutubeViewController: YoutubeModelDelegate {
    func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?) {
    }
    
    func onFetchFailed(with reason: String) {
    }
}
