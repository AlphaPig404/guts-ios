//
//  VideoEditVC.swift
//  Guts
//
//  Created by chris on 5/9/19.
//  Copyright © 2019 mozat. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class VideoEditVC: UIViewController {
    let videoView = UIView()
    var playerQueue:AVQueuePlayer?
    var player: AVPlayer?
    var playerItems: [AVPlayerItem]?
    var playList: [URL]?
    let backIconButton: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "icRecordingExit")
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    let nextButton: UIButton = {
        let bt = UIButton()
        bt.setTitle("Next", for: .normal)
        bt.setTitleColor(UIColor.black, for: .normal)
        bt.backgroundColor = UIColor.rgb(red: 244, green: 249, blue: 151)
        bt.layer.masksToBounds = true
        bt.layer.cornerRadius = 4
        return bt
    }()
    
    func initBy(list: [URL]){
        playList = list
        playerItems = playList!.map{ path in
            return AVPlayerItem(url: path)
        }
        playerQueue = AVQueuePlayer(items: playerItems!)
        playerQueue?.play()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.black
        view.addSubview(videoView)
        view.addSubview(backIconButton)
        view.addSubview(nextButton)
        setupVideoView()
        makeConstrains()
        NotificationCenter.default.addObserver(self, selector: #selector(playerEndedPlaying), name: .AVPlayerItemDidPlayToEndTime, object: nil)
        backIconButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapCloseIcon)))
        nextButton.addTarget(self, action: #selector(tapNextButton), for: .touchUpInside)
    }
    
    func makeConstrains(){
        videoView.snp_makeConstraints{
            $0.right.left.equalToSuperview()
            $0.top.equalToSuperview().offset(44)
            $0.bottom.equalToSuperview().offset(-68)
        }
        backIconButton.snp_makeConstraints{
            $0.top.equalToSuperview().offset(64)
            $0.left.equalToSuperview().offset(20)
        }
        nextButton.snp_makeConstraints{
            $0.width.equalTo(76)
            $0.height.equalTo(28)
            $0.bottom.equalToSuperview().offset(-20)
            $0.right.equalToSuperview().offset(-20)
        }
    }
    
    func setupVideoView(){
        let layer = AVPlayerLayer(player: playerQueue!)
        DispatchQueue.main.async {
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            layer.frame = self.videoView.bounds
            CATransaction.commit()
        }
        layer.videoGravity = .resizeAspectFill
        layer.backgroundColor = UIColor.white.cgColor
        videoView.layer.addSublayer(layer)
        videoView.layer.masksToBounds = true
        videoView.layer.cornerRadius = 10
    }
    
    @objc func playerEndedPlaying(_ notification: Notification){
        if let playerItem = notification.object as? AVPlayerItem{
            self.playerQueue?.remove(playerItem)
            playerItem.seek(to: .zero, completionHandler: nil)
            self.playerQueue?.insert(playerItem, after: nil)
        }
    }
    
    @objc func tapCloseIcon(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc func tapNextButton(){
        let postPage = PostVideoVC()
        postPage.assetUrl = playList![0]
        navigationController?.pushViewController(postPage, animated: true)
    }
}
