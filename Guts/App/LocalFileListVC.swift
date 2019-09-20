//
//  LocalFileList.swift
//  Guts
//
//  Created by chris on 4/9/19.
//  Copyright © 2019 mozat. All rights reserved.
//

import Foundation
import UIKit

class LocalFileListVC: UIViewController {
    let cellId = "cell"
    let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.dataSource = self
        tv.delegate = self
        tv.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        return tv
    }()
    
    lazy var localFileList:[String] = {
        var filePaths = [String]()
        let fileManager = FileManager()
        do{
            filePaths = try fileManager.contentsOfDirectory(atPath: path)
        }catch{
            
        }
        return filePaths
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidLoad() {
        view.addSubview(tableView)
        makeConstrains()
    }
    
    func makeConstrains(){
        tableView.snp_makeConstraints{
            $0.top.right.bottom.left.equalToSuperview()
        }
    }
}

extension LocalFileListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return localFileList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = localFileList[indexPath.row]
        cell.tag = indexPath.row
        cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapCell(sender:))))
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            localFileList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    @objc func tapCell(sender: UITapGestureRecognizer){
        let index = sender.view!.tag
        print(localFileList[index])
        let videoEditPage = VideoEditVC()
        let absolutePath = (path as NSString).appendingPathComponent(localFileList[index])
        let aseetUrl = URL(fileURLWithPath: absolutePath)
        videoEditPage.initBy(list: [aseetUrl, aseetUrl, aseetUrl])
        navigationController?.pushViewController(videoEditPage, animated: true)
    }
}
