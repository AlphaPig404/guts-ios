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
       //phoneFiled.alignTop("\(view.safeAreaInsets.top)", leading: "0", bottom: nil, trailing: "0", to: self.view)
    }
    
    override func viewDidLoad() {
        
        self.view.backgroundColor = UIColor.white
        phoneFiled = UISearchBar.init()
        self.view.addSubview(phoneFiled)
        print(view.safeAreaInsets.top);
        //[self.webView constrainTopSpaceToView:self.flk_topLayoutGuide predicate:@"0"];
    
        //phoneFiled.constrainTopSpace(to: self.flk, predicate: <#T##String!#>)
        phoneFiled.alignCenterX(with: self.view, predicate: nil)
        phoneFiled.alignTop(nil, leading: "0", bottom: nil, trailing: "0", to: self.view)
        //phoneFiled.constrainTopSpace(to: self.view, predicate: "100")
        phoneFiled.constrainHeight("50")
        phoneFiled.placeholder = "hello"
        //phoneFiled.translatesAutoresizingMaskIntoConstraints = false
        let myViewHeightConstraint = phoneFiled.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: view.safeAreaInsets.bottom)
        myViewHeightConstraint.isActive = true
    }
    
    func initView(){
        
    }
}
