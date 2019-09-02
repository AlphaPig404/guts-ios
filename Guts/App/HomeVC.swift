//
//  HomeViewController.swift
//  Guts
//
//  Created by chris on 28/8/19.
//  Copyright © 2019 mozat. All rights reserved.
//

import Foundation
import UIKit

enum Role: String, CaseIterable{
    case Player = "Player"
    case Watcher = "Watcher"
}

class HomeViewController: UIViewController, FeedCellButtonDelegate {
    let cellID = "feedCell"
    let bgColor = UIColor.rgb(red: 43, green: 43, blue: 48)
    
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
        cv.register(FeedCell.self, forCellWithReuseIdentifier: cellID)
        cv.delegate = self
        cv.dataSource = self
        cv.contentInsetAdjustmentBehavior = .never
        cv.isPagingEnabled = true
        return cv
    }()
    
    lazy var segment:UISegmentedControl = {
        let segment = UISegmentedControl(items: [Role.Player.rawValue, Role.Watcher.rawValue])
        segment.sizeToFit()
        segment.tintColor = UIColor.rgb(red: 99, green: 99, blue: 102)
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
        let indexPath = IndexPath(item: segment.selectedSegmentIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    func setupNav(){
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = bgColor
        navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationItem.titleView = segment
    }
    
    func handleTap(role: Role, at index: Int) {
        switch role {
        case .Player:
            print(role, index)
            let recordRoom = RecrodRoom()
            navigationController?.pushViewController(recordRoom, animated: true)
        case .Watcher:
            let watchRoom = WatchRoom()
            navigationController?.pushViewController(watchRoom, animated: true)
        }
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Role.allCases.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! FeedCell
        cell.delegate = self
        cell.role = Role.allCases[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return  CGSize(width: view.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        segment.selectedSegmentIndex = Int(scrollView.contentOffset.x/scrollView.frame.width)
    }
}
