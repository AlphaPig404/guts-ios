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
        let container = UIView()
        self.view.addSubview(container)
        //container.align(to: self.view)
        container.alignTop(nil, leading: "0", bottom: nil, trailing: "0", to: view)
        container.translatesAutoresizingMaskIntoConstraints = false
        let containerHeightConstraint = container.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,constant: view.safeAreaInsets.bottom)
        containerHeightConstraint.isActive = true

        phoneFiled = UISearchBar.init()

        container.addSubview(phoneFiled)
        print(view.safeAreaInsets.top);
        //[self.webView constrainTopSpaceToView:self.flk_topLayoutGuide predicate:@"0"];
    
        //phoneFiled.constrainTopSpace(to: self.flk, predicate: <#T##String!#>)
        phoneFiled.alignCenterX(with: container, predicate: nil)
        phoneFiled.alignTop("0", leading: "0", bottom: nil, trailing: "0", to: container)
        //phoneFiled.constrainTopSpace(to: self.view, predicate: "100")
        phoneFiled.constrainHeight("50")
        phoneFiled.placeholder = "hello"

    }
    
    func initView(){
        
    }
}
