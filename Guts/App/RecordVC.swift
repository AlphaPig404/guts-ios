//
//  RecordVC.swift
//  Guts
//
//  Created by chris on 2/9/19.
//  Copyright © 2019 mozat. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class RecrodRoom: UIViewController {
    var session: AVCaptureSession?
    var device: AVCaptureDevice?
    var input: AVCaptureDeviceInput?
    var output: AVCaptureMetadataOutput?
    var prevLayer: AVCaptureVideoPreviewLayer?
    
    let progressBar = ProgressBar()
    
    var closeIconButton: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "icRecordingExit"))
        return iv
    }()
    
    var titleLabel: UILabel = {
        let lv = UILabel()
        lv.text = "Sing in a full resturant"
        lv.textAlignment = .center
        lv.textColor = UIColor.white
        return lv
    }()
    
    var switchIconButton: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "icRoomSwitchcamera"))
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    var recordIconButton: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "icRecordingStart"))
        return iv
    }()
    
    var delIconButton: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "icRecordingDel"))
        return iv
    }()
    
    var confirmIconButton: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "icRecording"))
        return iv
    }()
    
    override func viewDidLoad() {
        createSession()
        view.addSubview(progressBar)
        view.addSubview(recordIconButton)
        view.addSubview(delIconButton)
        view.addSubview(confirmIconButton)
        view.addSubview(closeIconButton)
        view.addSubview(titleLabel)
        view.addSubview(switchIconButton)
        
        makeConstraints()
    }
    
    func makeConstraints(){
        let padding = 10
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        
        progressBar.snp_makeConstraints{
            $0.left.equalToSuperview().offset(padding)
            $0.right.equalToSuperview().offset(-padding)
            $0.top.equalToSuperview().offset(statusBarHeight)
        }
        
        closeIconButton.snp_makeConstraints{
            $0.width.equalTo(16)
            $0.height.equalTo(16)
            $0.left.equalTo(progressBar).offset(6)
            $0.top.equalTo(progressBar.snp_bottom).offset(27)
        }
        
        switchIconButton.snp_makeConstraints{
            $0.width.equalTo(36)
            $0.height.equalTo(36)
            $0.centerY.equalTo(closeIconButton.snp_centerY)
            $0.trailing.equalTo(progressBar)
        }
        
        titleLabel.snp_makeConstraints{
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(closeIconButton.snp_centerY)
        }
        
        recordIconButton.snp_makeConstraints{
            $0.width.equalTo(80)
            $0.height.equalTo(80)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-14)
        }
        
        delIconButton.snp_makeConstraints{
            $0.width.equalTo(36)
            $0.height.equalTo(36)
            $0.centerY.equalTo(recordIconButton.snp_centerY)
            $0.left.equalTo(recordIconButton.snp_right).offset(36)
        }
        
        confirmIconButton.snp_makeConstraints{
            $0.width.equalTo(36)
            $0.height.equalTo(36)
            $0.centerY.equalTo(recordIconButton.snp_centerY)
            $0.right.equalTo(recordIconButton.snp_left).offset(-36)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func createSession(){
        session = AVCaptureSession()
        device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front)
        do{
            input = try AVCaptureDeviceInput(device: device!)
        }catch{
            
        }
        session?.addInput(input!)
        
        prevLayer = AVCaptureVideoPreviewLayer(session: session!)
        prevLayer?.frame.size = view.frame.size
        prevLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        
        view.layer.addSublayer(prevLayer!)
        session?.startRunning()
    }
}
