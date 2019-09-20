//
//  SeleceVideoAccess.swift
//  Guts
//
//  Created by chris on 16/9/19.
//  Copyright © 2019 mozat. All rights reserved.
//

import Foundation
import UIKit

class SelectVideoAccessVC: UIViewController {
    let cellId = "cellId"
    
    let closeButton: UIButton = {
        let bt = UIButton()
        bt.setImage(UIImage(text: Iconfont.back, fontSize: 18, imageSize: CGSize(width: 20, height: 20),imageColor: .white), for: .normal)
        return bt
    }()
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        tv.dataSource = self
        tv.delegate = self
        tv.backgroundColor = .clear
        tv.separatorStyle = .none
        return tv
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidLoad() {
        view.addSubview(tableView)
        makeConstraints()
    }
    
    func makeConstraints(){
        tableView.snp_makeConstraints{
            $0.top.right.bottom.left.equalToSuperview()
        }
    }
}

extension SelectVideoAccessVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        cell.textLabel?.text = "测试"
        cell.backgroundColor = .clear
        cell.textLabel?.textColor = .white
        cell.detailTextLabel?.text = "ceshi"
        return cell
    }
}
