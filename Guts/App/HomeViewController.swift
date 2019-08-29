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
    let collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.white
        let container = UIView()
        self.view.addSubview(container)
        container.alignTop(nil, leading: "0", bottom: "0", trailing: "0", to: view)
        container.translatesAutoresizingMaskIntoConstraints = false
        let containerHeightConstraint = container.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,constant: view.safeAreaInsets.bottom)
        containerHeightConstraint.isActive = true
        
        container.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.alignTop("0", leading: "0", bottom: "0", trailing: "0", to: container)
        collectionView.backgroundColor = UIColor.white
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIndentifier, for: indexPath)
        cell.backgroundColor = UIColor.blue
        return cell
    }
}
