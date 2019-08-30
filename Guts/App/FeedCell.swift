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
    let cellIndentifier = "cellId"
    
    lazy var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.size.width
        layout.estimatedItemSize = CGSize(width: width, height: 160)
        layout.itemSize = UICollectionViewFlowLayout.automaticSize
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(ChallengCell.self, forCellWithReuseIdentifier: "cellId")
        cv.delegate = self
        cv.dataSource = self
        cv.contentInsetAdjustmentBehavior = .never
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
        self.addSubview(collectionView)
        self.backgroundColor = UIColor.blue
        collectionView.align(to: self.contentView)
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIndentifier, for: indexPath)
        cell.backgroundColor = UIColor.rgb(red: 43, green: 43, blue: 48)
        return cell
    }
}
