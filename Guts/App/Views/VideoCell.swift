//
//  VideoCell.swift
//  Guts
//
//  Created by chris on 1/9/19.
//  Copyright © 2019 mozat. All rights reserved.
//

import Foundation
import UIKit
import AVKit

class VideoCell: UICollectionViewCell {
    var player: AVPlayer?
    var video: Video?
    
    let container: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .center
        return sv
    }()
    
    var avatar: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "cover"))
        iv.layer.cornerRadius = 30
        iv.clipsToBounds = true
        return iv
    }()
    
    var likedIcon = UIImageView(image: UIImage(named: "favorite"))
    
    var likeLabel = UILabel()
    
    var commentIcon = UIImageView(image: UIImage(named: "comment"))
    
    var commentLabel = UILabel()
    
    var shareIcon = UIImageView(image: UIImage(named: "share"))
    
    var shareLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        addVideoPlayer(to: self.contentView)
        contentView.addSubview(container)
        
        container.addArrangedSubview(avatar)
        container.setCustomSpacing(20, after: avatar)
        container.addArrangedSubview(likedIcon)
        container.addArrangedSubview(likeLabel)
        container.setCustomSpacing(20, after: likeLabel)
        container.addArrangedSubview(commentIcon)
        container.addArrangedSubview(commentLabel)
        container.setCustomSpacing(20, after: commentLabel)
        container.addArrangedSubview(shareIcon)
        container.addArrangedSubview(shareLabel)
        likeLabel.textColor = UIColor.white
        shareLabel.textColor = UIColor.white
        commentLabel.textColor = UIColor.white
    }
    
    override func layoutSubviews() {
        container.snp_makeConstraints{
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().offset(-10)
        }
        
        avatar.snp_makeConstraints{
            $0.width.equalTo(60)
            $0.height.equalTo(60)
        }
        
        likedIcon.snp_makeConstraints{
            $0.width.equalTo(40)
            $0.height.equalTo(40)
        }
        
        commentIcon.snp_makeConstraints{
            $0.width.equalTo(40)
            $0.height.equalTo(40)
        }
        
        shareIcon.snp_makeConstraints{
            $0.width.equalTo(40)
            $0.height.equalTo(40)
        }
    }
    
    func initData(_video: Video?){
        video = _video
        likeLabel.text = String(video!.favorites)
        commentLabel.text = String(video!.comments)
        shareLabel.text = String(video!.shares)
        guard let path = Bundle.main.path(forResource: video!.url, ofType:"mp4") else {
            debugPrint("video1.mp4 not found")
            return
        }
        player?.replaceCurrentItem(with: AVPlayerItem(url: URL(fileURLWithPath: path)))
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: self.player?.currentItem, queue: .main, using: {_ in
            self.player?.seek(to: CMTime.zero)
            self.player?.play()
        })
    }
    
    func addVideoPlayer(to view: UIView) {
        player = AVPlayer.init()
        let layer: AVPlayerLayer = AVPlayerLayer(player: player)
//        layer.backgroundColor = UIColor.white.cgColor
        layer.frame = view.bounds
        layer.videoGravity = .resizeAspectFill
        view.layer.sublayers?
            .filter { $0 is AVPlayerLayer }
            .forEach { $0.removeFromSuperlayer() }
        view.layer.addSublayer(layer)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapVideo)))
    }
    
    @objc func tapVideo(){
        player?.timeControlStatus == .playing ? player?.pause() : player?.play()
    }
}
