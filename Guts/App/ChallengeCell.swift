//
//  ChallengeCell.swift
//  Guts
//
//  Created by chris on 30/8/19.
//  Copyright © 2019 mozat. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class ChallengCell: UICollectionViewCell {
    let coverImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "cover")
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.text = "title"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    let detailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        label.textColor = UIColor.rgba(red: 119, green: 119, blue: 123, alpha: 1)
        label.text = "detail"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    let button: UIButton = {
        let button = UIButton()
        button.setTitle("Accept", for: .normal)
        button.setTitleColor(UIColor.rgb(red: 0, green: 174, blue: 255), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.backgroundColor = UIColor.rgba(red: 255, green: 255, blue: 255, alpha: 0.1)
        button.layer.cornerRadius = 14
        return button
    }()
    
    let expiredLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.text = "0:50"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    let levelLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.text = "EASY"
        return label
    }()
    
    let pointLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.text = "100 points"
        return label
    }()
    
    let levelIcon: UIView = {
        let icon = UIView()
        icon.backgroundColor = UIColor.red
        icon.layer.cornerRadius = 5
        return icon
    }()
    
    let pointIcon: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "icLike")
        return iv
    }()
    
    let playIcon: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "icTime")
        return iv
    }()
    
    let statusBar: UIView = {
        let view = UIView()
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        statusBar.translatesAutoresizingMaskIntoConstraints = false
        coverImage.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        addSubview(statusBar)
        statusBar.addSubview(levelIcon)
        statusBar.addSubview(levelLabel)
        statusBar.addSubview(pointLabel)
        statusBar.addSubview(pointIcon)
        statusBar.addSubview(expiredLabel)
        statusBar.addSubview(playIcon)
        addSubview(coverImage)
        addSubview(titleLabel)
        addSubview(detailLabel)
        addSubview(button)
        backgroundColor = UIColor.black
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let offsetH = 16
        
        statusBar.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(offsetH)
            $0.trailing.equalToSuperview().offset(-offsetH)
            $0.top.equalToSuperview().offset(12)
            $0.height.equalTo(40)
        }
        
        levelIcon.snp.makeConstraints{
            $0.width.equalTo(10)
            $0.height.equalTo(10)
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview()
        }
        
        levelLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.left.equalTo(levelIcon.snp_right).offset(5)
        }
        
        pointLabel.snp_makeConstraints{
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview()
        }
        
        pointIcon.snp_makeConstraints{
            $0.width.equalTo(13)
            $0.height.equalTo(12)
            $0.centerY.equalToSuperview()
            $0.right.equalTo(pointLabel.snp_left).offset(-5)
        }
        
        expiredLabel.snp_makeConstraints{
            $0.centerY.equalToSuperview()
            $0.right.equalTo(pointIcon.snp_left).offset(-10)
        }
        
        playIcon.snp_makeConstraints{
            $0.width.equalTo(14)
            $0.height.equalTo(14)
            $0.centerY.equalToSuperview()
            $0.right.equalTo(expiredLabel.snp_left).offset(-5)
        }
        
        coverImage.snp_makeConstraints{
            $0.width.equalTo(82)
            $0.height.equalTo(82)
            $0.top.equalTo(statusBar.snp_bottom)
            $0.trailing.equalTo(statusBar)
        }
        
        titleLabel.snp_makeConstraints{
            $0.leading.equalTo(statusBar)
            $0.top.equalTo(statusBar.snp_bottom)
        }
        
        detailLabel.snp_makeConstraints{
            $0.top.equalTo(titleLabel.snp_bottom)
            $0.leading.equalTo(statusBar)
        }
        
        button.snp_makeConstraints{
            $0.width.equalTo(76)
            $0.height.equalTo(28)
            $0.top.equalTo(detailLabel.snp_bottom).offset(21)
            $0.leading.equalTo(statusBar)
        }
        
        contentView.snp_makeConstraints{
            $0.top.left.right.equalToSuperview()
            $0.bottom.equalTo(button.snp_bottom)
        }
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        layoutAttributes.frame.size.height = contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        print("height: \(layoutAttributes.frame.size.height)")
        return layoutAttributes
    }
    
}
