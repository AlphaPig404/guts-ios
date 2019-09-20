//
//  PostVideoVC.swift
//  Guts
//
//  Created by chris on 11/9/19.
//  Copyright © 2019 mozat. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

struct TableItem {
    var image: UIImage?
    var label: String?
    var enable: Bool?
    
    init(image: UIImage, label: String){
        self.image = image
        self.label = label
    }
    
    init(image: UIImage, label: String, enable: Bool) {
        self.image = image
        self.label = label
        self.enable = enable
    }
}

class PostVideoVC: UIViewController {
    let cellId = "cellId"
    let tableList: [TableItem] = [
        TableItem(image: UIImage(text: Iconfont.lock, fontSize: 8, imageSize: CGSize(width: 10, height: 10), imageColor: UIColor.white)!, label: "Who Can View This Video"),
        TableItem(image: UIImage(text: Iconfont.comment_line, fontSize: 8, imageSize: CGSize(width: 10, height: 10), imageColor: UIColor.white)!, label: "Comments Off", enable: false),
        TableItem(image: UIImage(text: Iconfont.duet, fontSize: 8, imageSize: CGSize(width: 10, height: 10), imageColor: UIColor.white)!, label: "Due/React Off", enable: false),
        TableItem(image: UIImage(text: Iconfont.save, fontSize: 8, imageSize: CGSize(width: 10, height: 10), imageColor: UIColor.white)!, label: "Save to Album", enable: true)
    ]
    
    lazy var editBox: UITextView = {
        let tv = UITextView()
        tv.isEditable = true
        tv.text = "Discribe your video"
        tv.textColor = .lightGray
        tv.delegate = self
        tv.backgroundColor = UIColor.clear
        tv.font = UIFont.systemFont(ofSize: 14)
        return tv
    }()
    
    let wrapper = UIView()
    
    let playerView = UIView()
    
    var player:AVPlayer?
    
    var playerLayer: AVPlayerLayer?
    
    var assetUrl: URL?
    
    let divider:UIView = {
        let iv = UIView()
        iv.backgroundColor = UIColor.rgba(red: 255, green: 255, blue: 255, alpha: 0.2)
        return iv
    }()
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.register(PostSettingCell.self, forCellReuseIdentifier: cellId)
        tv.delegate = self
        tv.dataSource = self
        tv.separatorStyle = .none
        tv.alwaysBounceVertical = false
        tv.backgroundColor = UIColor.clear
        return tv
    }()
    
    let draftButton: UIButton = {
        let bt = UIButton()
        bt.setTitle("Drafts", for: .normal)
        bt.setTitleColor(.white, for: .normal)
        bt.layer.masksToBounds = true
        bt.layer.cornerRadius = 4
        bt.setImage(UIImage(text: Iconfont.draft, fontSize: 6, imageSize: CGSize(width: 10, height: 10), imageColor: .white), for: .normal)
        bt.backgroundColor = UIColor.rgba(red: 255, green: 255, blue: 255, alpha: 0.3)
        return bt
    }()
    
    let postButton: UIButton = {
        let bt = UIButton()
        bt.setTitle("Post", for: .normal)
        bt.setTitleColor(UIColor.black, for: .normal)
        bt.backgroundColor = UIColor.rgb(red: 244, green: 249, blue: 151)
        bt.layer.masksToBounds = true
        bt.layer.cornerRadius = 4
        bt.setImage(UIImage(text: Iconfont.upload, fontSize: 8, imageSize: CGSize(width: 10, height: 10), imageColor: .black), for: .normal)
        bt.imageView?.contentMode = .scaleAspectFit
       return bt
    }()
    
    let tableViewMask: UIView = {
        let iv = UIView()
        iv.backgroundColor = UIColor.rgba(red: 0, green: 0, blue: 0, alpha: 0.7)
        iv.isHidden = true
        return iv
    }()
    
    let transition: CATransition = {
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        transition.type = .moveIn
        transition.subtype = .fromTop
        return transition
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.rgb(red: 21, green: 23, blue: 34)
        setupPlayer()
        view.addSubview(wrapper)
        wrapper.addSubview(playerView)
        wrapper.addSubview(editBox)
        wrapper.addSubview(divider)
        wrapper.addSubview(tableView)
        wrapper.addSubview(draftButton)
        wrapper.addSubview(postButton)
        wrapper.addSubview(tableViewMask)
        makeConstraints()
        view.snapshotView(afterScreenUpdates: true)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        titleLabel.textColor = UIColor.white
        titleLabel.text = "Post"
        titleLabel.textAlignment = .center
        navigationItem.titleView = titleLabel
    }
    
    func setupPlayer(){
        if let url = assetUrl {
            player = AVPlayer(url: url)
            playerLayer = AVPlayerLayer(player: player!)
            DispatchQueue.main.async {
                self.playerLayer?.frame = self.playerView.bounds
            }
            playerLayer?.videoGravity = .resizeAspectFill
            playerView.layer.addSublayer(playerLayer!)
        }
    }
    
    func makeConstraints(){
        wrapper.snp_makeConstraints{
            $0.edges.equalTo(UIEdgeInsets(top: 10, left: 10, bottom: 50, right: 10))
        }
        
        playerView.snp_makeConstraints{
            $0.right.top.equalToSuperview()
            $0.width.equalTo(90)
            $0.height.equalTo(120)
        }
        
        editBox.snp_makeConstraints{
            $0.left.equalToSuperview()
            $0.top.equalTo(playerView.snp_top)
            $0.right.equalTo(playerView.snp_left)
            $0.bottom.equalTo(playerView.snp_bottom)
        }
        
        divider.snp_makeConstraints{
            $0.left.right.equalToSuperview()
            $0.top.equalTo(playerView.snp_bottom).offset(10)
            $0.height.equalTo(1)
        }
        
        tableView.snp_makeConstraints{
            $0.left.right.equalToSuperview()
            $0.top.equalTo(divider.snp_bottom).offset(10)
            $0.bottom.equalTo(postButton.snp_top)
        }
        
        tableViewMask.snp_makeConstraints{
            $0.left.right.equalTo(view)
            $0.top.equalTo(divider.snp_bottom)
            $0.bottom.equalTo(postButton.snp_top)
        }
        
        draftButton.snp_makeConstraints{
            $0.width.equalTo(postButton)
            $0.height.equalTo(48)
            $0.bottom.leading.equalToSuperview()
        }
    
        postButton.snp_makeConstraints{
            $0.width.height.equalTo(draftButton)
            $0.bottom.right.equalToSuperview()
            $0.leading.equalTo(draftButton.snp_trailing).offset(10)
        }
    }
    
    @objc func keyboardWillShow(){
        tableViewMask.isHidden = false
        print("show")
    }
    
    @objc func keyboardWillHide(){
        tableViewMask.isHidden = true
         print("hide")
    }
    
    @objc func dismissModal(){
        print("dismiss")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        
    }
}

extension PostVideoVC: UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if editBox.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.white
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Placeholder"
            textView.textColor = UIColor.lightGray
        }
    }
}

extension PostVideoVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: cellId)
        let tableItem = tableList[indexPath.row]
        cell.imageView?.image = tableItem.image
        cell.textLabel?.text = tableItem.label
        if tableItem.enable != nil {
            cell.accessoryView = UISwitch(frame: CGRect(x: 0, y: 0, width: 50, height: 30))
        }else{
            let rightLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 20, height: 30))
            
            rightLabel.text = Iconfont.back.rawValue
            rightLabel.font = UIFont.iconfont(ofSize: 14)
            rightLabel.textAlignment = .right
            rightLabel.textColor = UIColor.gray
            cell.detailTextLabel?.text = "Public"
            cell.accessoryView = rightLabel
        }
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.textColor = UIColor.white
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            let selectVideoAceessPage = SelectVideoAccessVC()
            navigationController?.view.layer.add(transition, forKey: kCATransition)
            navigationController?.pushViewController(selectVideoAceessPage, animated: false)
        }
    }
}
