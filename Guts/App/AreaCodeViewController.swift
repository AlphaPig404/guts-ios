//
//  AreaCodeViewController.swift
//  Guts
//
//  Created by chris on 28/8/19.
//  Copyright © 2019 mozat. All rights reserved.
//

import Foundation
import UIKit
import FLKAutoLayout

class AreaCodeViewController: UIViewController {
    var phoneFiled: UISearchBar!
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationItem.title = "Select a country"
    }
    
    override func viewDidAppear(_ animated: Bool) {
       phoneFiled.alignTop("\(view.safeAreaInsets.top)", leading: "0", bottom: nil, trailing: "0", to: self.view)
    }
    
    override func viewDidLoad() {
        
        self.view.backgroundColor = UIColor.white
        phoneFiled = UISearchBar.init()
        self.view.addSubview(phoneFiled)
        print(view.safeAreaInsets.top);
        //[self.webView constrainTopSpaceToView:self.flk_topLayoutGuide predicate:@"0"];
    
        //phoneFiled.constrainTopSpace(to: self.flk, predicate: <#T##String!#>)
        phoneFiled.alignCenterX(with: self.view, predicate: nil)
//        phoneFiled.alignTop("\(safeAreaTop)", leading: "0", bottom: nil, trailing: "0", to: self.view)
        //phoneFiled.constrainTopSpace(to: self.view, predicate: "100")
        phoneFiled.constrainHeight("50")
        phoneFiled.placeholder = "hello"
        //let a = phoneFiled.topAnchor.constraint(equalTo: self.view.topAnchor)
        //NSLayoutConstraint.activate([a])
        
        
        //[self addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
//        let constraint = NSLayoutConstraint.init(item: phoneFiled, attribute: .top, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .bottom, multiplier: 1, constant: 0)
//        phoneFiled.addConstraint(constraint)
        //phoneFiled.addConstraint(self.view.safeAreaLayoutGuide.bottomAnchor)
        
        //
//        let icon = UIImageView()
//        icon.image = UIImage.init(named: "search")
//        self.view.addSubview(icon)
//        //icon.alignLeading("0", trailing: nil, to: phoneFiled)
//        icon.alignTop("0", leading: "0", bottom: "0", trailing: nil, to: phoneFiled)
//        icon.constrainWidth("50")
//        icon.backgroundColor = UIColor.red
    }
    
    func initView(){
        
    }
}
