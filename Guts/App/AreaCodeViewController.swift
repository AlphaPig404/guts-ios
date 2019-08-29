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

protocol ReturnValueDelegate {
    func returnValue(params: String)
}

class AreaCodeViewController: UIViewController {
    let cellID = "cell"
    var areaDic: NSDictionary = [:]
    var areaHeaders = [String]()
    var areaArr = [String]()
    var delgete: ReturnValueDelegate?
    let searchBarHeight = "50"
    var searchArray = [String]()
    var isSearch = false
    var tableView = UITableView()
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationItem.title = "Select a country"
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.white
        let container = UIView()
        self.view.addSubview(container)
        container.alignTop(nil, leading: "0", bottom: "0", trailing: "0", to: view)
        container.translatesAutoresizingMaskIntoConstraints = false
        let containerHeightConstraint = container.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,constant: view.safeAreaInsets.bottom)
        containerHeightConstraint.isActive = true
        
        initData()
        initView(container: container)
    }
    
    func initData(){
        let path = Bundle.main.path(forResource: "area_code", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        do{
            let data = try Data(contentsOf: url)
            let jsonData:Any = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableLeaves)
            let jsonDic = jsonData as! NSDictionary
            areaDic = jsonDic
            for (key, value) in jsonDic{
                areaHeaders.append(key as! String)
                
                areaArr.append(contentsOf: value as! Array)
            }
            areaHeaders.sort()
        }catch let error as Error?{
            print("read json data error", error ?? "")
        }
    }
    
    func initView(container: UIView){
        let searchBar = UISearchBar.init()
        container.addSubview(searchBar)
        searchBar.alignCenterX(with: container, predicate: nil)
        searchBar.alignTop("0", leading: "0", bottom: nil, trailing: "0", to: container)
        searchBar.constrainHeight(searchBarHeight)
        searchBar.placeholder = "Search"
        searchBar.delegate = self
        
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.alignTop(nil, leading: "0", bottom: "0", trailing: "0", to: view!)
        tableView.alignTop(searchBarHeight, leading: nil, to: searchBar)
    }
}

extension AreaCodeViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(!isSearch){
            let areaSection = areaDic[areaHeaders[section]] as! NSArray
            return areaSection.count
        }else{
            return searchArray.count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return isSearch ? 1 : areaHeaders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: cellID)
        var areaStr:String
        if(isSearch){
            areaStr = searchArray[indexPath.row]
        }else{
            let areaSection = areaDic[areaHeaders[indexPath.section]] as! NSArray
            areaStr = areaSection[indexPath.row] as! String
        }
        cell.textLabel?.text = "\(areaStr.split(separator: ",")[0])"
        cell.detailTextLabel?.text = "\(areaStr.split(separator: ",")[1])"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var areaStr:String
        if(isSearch){
            areaStr = searchArray[indexPath.row]
        }else{
            let areaSection = areaDic[areaHeaders[indexPath.section]] as! NSArray
            areaStr = areaSection[indexPath.row] as! String
        }
        let areaCodeStr = areaStr.split(separator: ",")[1]
        let index = areaCodeStr.index(after: areaCodeStr.startIndex)
        let areaCode = areaCodeStr[index...]
        self.delgete?.returnValue(params: String(areaCode))
        navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return isSearch ? "" : "\(areaHeaders[section])"
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return areaHeaders
    }
}

extension AreaCodeViewController: UISearchBarDelegate{
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        logger.log("cancel")
        isSearch = false
        searchBar.resignFirstResponder()
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        logger.log(searchText)
        searchArray = areaArr.filter{ $0.range(of: searchText) != nil}
        print("\(searchArray)")
        if(searchArray.count == 0 && searchText.count == 0){
            isSearch = false
        }else{
            isSearch = true
        }
        tableView.reloadData()
    }
}
