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
import RxSwift

typealias ShowDetailsClosure = (String) -> Void

protocol returnValueDelegate {
    func returnValue(params: String)
}

class AreaCodeViewController: UIViewController {
    let cellID = "cell"
    var areaDic: NSDictionary = [:]
    var areaHeaders = [String]()
    var showDetailClousrue: ShowDetailsClosure?
    var tableView: UITableView?
    
    lazy var viewModel: AreaCodeViewModel = {
        return AreaCodeViewModel()
    }()
    
    deinit {
        logger.log("deinit ~~")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationItem.title = "Select a country"
        
        viewModel
            .numberOfArea()
            .subscribe(onNext: { [weak self] area, json in
                if let strongSelf = self {
                    strongSelf.areaHeaders = area
                    strongSelf.areaDic = json
                    strongSelf.tableView?.reloadData()
                }
        }, onError: nil,
           onCompleted: {
            logger.log("completed")
        }).disposed(by: DisposeBag())
    }
    
    override func viewDidLoad() {
        let searchBarHeight = "50"
        self.view.backgroundColor = UIColor.white
        let container = UIView()
        self.view.addSubview(container)
        container.alignTop(nil, leading: "0", bottom: "0", trailing: "0", to: view)
        container.translatesAutoresizingMaskIntoConstraints = false
        let containerHeightConstraint = container.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,constant: view.safeAreaInsets.bottom)
        containerHeightConstraint.isActive = true
        let phoneFiled = UISearchBar.init()
        container.addSubview(phoneFiled)
        phoneFiled.alignCenterX(with: container, predicate: nil)
        phoneFiled.alignTop("0", leading: "0", bottom: nil, trailing: "0", to: container)
        phoneFiled.constrainHeight(searchBarHeight)
        phoneFiled.placeholder = "Search"
        
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.alignTop(nil, leading: "0", bottom: "0", trailing: "0", to: view!)
        tableView.alignTop(searchBarHeight, leading: nil, to: phoneFiled)
        self.tableView = tableView
    }
    
    func initView(){
        
    }
}

extension AreaCodeViewController:UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let areaSection = areaDic[areaHeaders[section]] as! NSArray
        return areaSection.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return areaHeaders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: cellID)
        let areaSection = areaDic[areaHeaders[indexPath.section]] as! NSArray
        let areaStr = areaSection[indexPath.row] as! String
        cell.textLabel?.text = "\(areaStr.split(separator: ",")[0])"
        cell.detailTextLabel?.text = "\(areaStr.split(separator: ",")[1])"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let areaSection = areaDic[areaHeaders[indexPath.section]] as! NSArray
        let areaStr = areaSection[indexPath.row] as! String
        let areaCodeStr = areaStr.split(separator: ",")[1]
        let index = areaCodeStr.index(after: areaCodeStr.startIndex)
        let areaCode = areaCodeStr[index...]
        
        logger.log("点击了\(areaCode)")
        if let showDetialClouser_ = self.showDetailClousrue {
            showDetialClouser_(areaStr)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(areaHeaders[section])"
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return areaHeaders
    }
}
