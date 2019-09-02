//
//  FeedCell.swift
//  Guts
//
//  Created by chris on 30/8/19.
//  Copyright © 2019 mozat. All rights reserved.
//

import Foundation
import UIKit

class FeedCell: UICollectionViewCell {
    let cellID = "cellId"
    var role: Role?
    var delegate: FeedCellButtonDelegate?
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.size.width
        layout.estimatedItemSize = CGSize(width: width, height: 1)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(ChallengCell.self, forCellWithReuseIdentifier: cellID)
        cv.delegate = self
        cv.dataSource = self
        cv.contentInsetAdjustmentBehavior = .never
        cv.backgroundColor = UIColor.rgb(red: 60, green: 60, blue: 64)
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        contentView.addSubview(collectionView)
        collectionView.align(to: self.contentView)
    }
    
    @objc func handleClick(_ sender: UIButton){
        delegate?.handleTap(role: role!, at: sender.tag)
    }
}


extension FeedCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! ChallengCell
        cell.button.tag = indexPath.row
        cell.button.addTarget(self, action: #selector(handleClick), for: .touchUpInside)
        switch role!{
            case .Player:
                cell.button.setTitle("Accept", for: .normal)
            case .Watcher:
                cell.button.setTitle("Watch", for: .normal)
        }
        cell.backgroundColor = UIColor.rgb(red: 43, green: 43, blue: 48)
        return cell
    }
}
