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

protocol returnValueDelegate {
    func returnValue(params: String)
}

class AreaCodeViewController: UIViewController {
    let cellID = "cell"
    var areaDic: NSDictionary = [:]
    var areaHeaders = [String]()
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationItem.title = "Select a country"
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
        
        let path = Bundle.main.path(forResource: "area_code", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        do{
            let data = try Data(contentsOf: url)
            let jsonData:Any = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableLeaves)
            let jsonDic = jsonData as! NSDictionary
            areaDic = jsonDic
            for (key, _) in jsonDic{
                areaHeaders.append(key as! String)
            }
            areaHeaders.sort()
        }catch let error as Error?{
            print("read json data error", error ?? "")
        }
        
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.alignTop(nil, leading: "0", bottom: "0", trailing: "0", to: view!)
        tableView.alignTop(searchBarHeight, leading: nil, to: phoneFiled)
    
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
        navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(areaHeaders[section])"
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return areaHeaders
    }
}
