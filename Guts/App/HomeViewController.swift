//
//  HomeViewController.swift
//  Guts
//
//  Created by chris on 28/8/19.
//  Copyright © 2019 mozat. All rights reserved.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    var items = ["1","2"]
    let cellIndentifier = "cell"
    let bgColors: [UIColor] = [.blue,.red]
    let bgColor = UIColor(red:43/255, green:43/255, blue:48/255, alpha:1.00)
    
    lazy var container:UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    lazy var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(FeedCell.self, forCellWithReuseIdentifier: "cell")
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = UIColor.black
        cv.contentInsetAdjustmentBehavior = .never
        cv.isPagingEnabled = true
        return cv
    }()
    
    lazy var segment:UISegmentedControl = {
        let segment = UISegmentedControl(items: ["Player","Watcher"])
        segment.sizeToFit()
        segment.tintColor = UIColor(red: 99/255, green: 99/255, blue: 102/255, alpha: 1.0)
        segment.selectedSegmentIndex = 0
        segment.addTarget(self, action: #selector(selectSegment), for: .valueChanged)
        return segment
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    override func viewDidLoad() {
        setupNav()
        self.view.addSubview(container)
        let containerHeightConstraint = container.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,constant: view.safeAreaInsets.bottom)
        containerHeightConstraint.isActive = true
        container.alignTop(nil, leading: "0", bottom: "0", trailing: "0", to: view)
        container.addSubview(collectionView)
        collectionView.alignTop("0", leading: "0", bottom: "0", trailing: "0", to: container)
    }
    
    @objc func selectSegment(){
        print(segment.selectedSegmentIndex)
    }
    
    func setupNav(){
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = bgColor
        navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationItem.titleView = segment
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIndentifier, for: indexPath)
//        cell.backgroundColor = bgColors[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return  CGSize(width: view.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        logger.log("end")
        logger.log("\(scrollView.contentOffset.x)")
    }
}
