//
//  WatchRoom.swift
//  Guts
//
//  Created by chris on 31/8/19.
//  Copyright © 2019 mozat. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class WatchRoom: UIViewController {
    let cellId = "videoCell"
    let mockVideoList = [
        Video.init(id: 1, url: "video1", favorites: 40, comments: 40, shares: 4, favorited: false),
        Video.init(id: 2, url: "video2", favorites: 40, comments: 40, shares: 4, favorited: false),
        Video.init(id: 3, url: "video3", favorites: 40, comments: 40, shares: 4, favorited: false),
        Video.init(id: 4, url: "video4", favorites: 40, comments: 40, shares: 4, favorited: false)
    ]
    
    var playerList: [AVPlayer] = []
    
    var currentIndex: Int = 0
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(VideoCell.self, forCellWithReuseIdentifier: cellId)
        cv.delegate = self
        cv.dataSource = self
        cv.contentInsetAdjustmentBehavior = .never
        cv.isPagingEnabled = true
        return cv
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        self.view.addSubview(collectionView)
    }
    
    override func viewWillLayoutSubviews() {
        collectionView.snp_makeConstraints{
            $0.top.right.bottom.left.equalToSuperview()
        }
    }
}

extension WatchRoom: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mockVideoList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! VideoCell
        let video = mockVideoList[indexPath.row]
        cell.initData(_video: video)
        if(playerList.count <= indexPath.row){
            playerList.append(cell.player!)
        }
        if(currentIndex == 0){
            playerList[0].play()
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        currentIndex = Int(scrollView.contentOffset.y/view.frame.height)
        playerList.forEach{ player in
            player.pause()
        }
        playerList[currentIndex].play()
    }
}

