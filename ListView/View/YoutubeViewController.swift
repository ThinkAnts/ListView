//
//  YoutubeViewController.swift
//  ListView
//
//  Created by Ravi Kishore on 9/21/19.
//  Copyright © 2019 ThinkAnts. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class YoutubeViewController: UIViewController {
    private enum CellIdentifiers {
        static let youtube = "Youtube"
    }
    @IBOutlet weak var youtubeTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        youtubeTableView.register(UINib.init(nibName: "YoutubeTableViewCell", bundle: Bundle.main),
                                  forCellReuseIdentifier: CellIdentifiers.youtube)
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
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.youtube, for: indexPath) as? YoutubeTableViewCell else {
            return UITableViewCell()
        }
        cell.titleLabel.text = "Big Buck Bunndy Video"
        guard let videoUrl = URL(string:"https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4") else { return UITableViewCell() }
        let avPlayer = AVPlayer(url: videoUrl)
        cell.playerView?.playerLayer.frame = cell.frame
        cell.playerView?.playerLayer.player = avPlayer
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300.0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //guard let videoCell = (cell as? YoutubeTableViewCell) else { return }
//        let visibleCells = tableView.visibleCells
//        let minIndex = visibleCells.startIndex
//        if tableView.indexPathsForVisibleRows?.first?.row == minIndex {
//            videoCell.playerView.player?.play()
//        }
        let middleIndex = ((tableView.indexPathsForVisibleRows?.first?.row)! + (tableView.indexPathsForVisibleRows?.last?.row)!)/2
        if indexPath.row == middleIndex {
            guard let cell = tableView.cellForRow(at: indexPath) as? YoutubeTableViewCell else {return }
            cell.playerView.player?.play()
        }
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let videoCell = cell as? YoutubeTableViewCell else { return }
        videoCell.playerView.player?.pause()
        videoCell.playerView.player = nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let videoLauncher = VideoLauncher()
        videoLauncher.showVideoPlayer()
    }
    
}
