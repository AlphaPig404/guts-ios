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
    var movieFile: AVCaptureMovieFileOutput?
    
    let progressBar = ProgressBar()
    let sessionQueue = DispatchQueue(label: "com.guts.sessionQueue")
    
    var cameraView = UIView()
    
    var closeIconButton: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "icRecordingExit"))
        iv.isUserInteractionEnabled = true
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
        iv.isUserInteractionEnabled = true
        iv.isMultipleTouchEnabled = true
        return iv
    }()
    
    var recordIconButton: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "icRecordingStart"))
        iv.isUserInteractionEnabled = true
        iv.isMultipleTouchEnabled = true
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
    
    var fileIconButton: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "icRoomSwitchcamera"))
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    override func viewDidLoad() {
        view.addSubview(cameraView)
        createSession(to: cameraView)
        view.addSubview(progressBar)
        view.addSubview(recordIconButton)
        view.addSubview(delIconButton)
        view.addSubview(confirmIconButton)
        view.addSubview(closeIconButton)
        view.addSubview(titleLabel)
        view.addSubview(switchIconButton)
        view.addSubview(fileIconButton)
        delIconButton.isHidden = true
        confirmIconButton.isHidden = true
        
        closeIconButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(cancelRecord)))
        switchIconButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(switchCamera)))
        recordIconButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(recordVideo)))
        fileIconButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(gotoLocalFilePage)))
        makeConstraints()
    }
    
    func makeConstraints(){
        let padding = 10
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        
        cameraView.snp_makeConstraints{
            $0.top.right.bottom.left.equalToSuperview()
        }
        
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
        
        fileIconButton.snp_makeConstraints{
            $0.width.equalTo(36)
            $0.height.equalTo(36)
            $0.centerX.equalTo(switchIconButton.snp_centerX)
            $0.top.equalTo(switchIconButton.snp_bottom).offset(100)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func createSession(to container: UIView){
        session = AVCaptureSession()
        device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front)
        do{
            input = try AVCaptureDeviceInput(device: device!)
        }catch{
            
        }
        session?.addInput(input!)
        prevLayer = AVCaptureVideoPreviewLayer(session: session!)
        let connect = AVCaptureConnection(inputPort: (input?.ports.first)!, videoPreviewLayer: prevLayer!)
        connect.isEnabled = false
        prevLayer?.frame.size = view.frame.size
        prevLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        container.layer.addSublayer(prevLayer!)
        self.session?.startRunning()
    }
    
    @objc func switchCamera(){
        if let session = session {
            let currentCameraInput = session.inputs[0]
            session.removeInput(currentCameraInput)
            var newCamera = AVCaptureDevice.default(for: AVMediaType.video)
            if(currentCameraInput as! AVCaptureDeviceInput).device.position == .back{
                UIView.transition(with: self.cameraView, duration: 0.5, options: .transitionFlipFromLeft, animations: {
                    newCamera = self.cameraWithPosition(.front)!
                }, completion: nil)
            }else{
                UIView.transition(with: self.cameraView, duration: 0.5, options: .transitionFlipFromRight, animations: {
                    newCamera = self.cameraWithPosition(.back)
                }, completion: nil)
            }
            
            do {
                try session.addInput(AVCaptureDeviceInput(device: newCamera!))
            }catch{
                print("error: \(error.localizedDescription)")
            }
        }
        
    }
    
    func cameraWithPosition(_ position: AVCaptureDevice.Position) -> AVCaptureDevice? {
        let deviceDescoverySession = AVCaptureDevice.DiscoverySession.init(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position.unspecified)
        
        for device in deviceDescoverySession.devices {
            if device.position == position {
                return device
            }
        }
        return nil
    }
    
    @objc func cancelRecord(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc func recordVideo(){
        if movieFile == nil {
            movieFile = AVCaptureMovieFileOutput()
            session?.addOutput(movieFile!)
            if let connection = movieFile?.connection(with: .video){
                if connection.isVideoMirroringSupported {
                    connection.isVideoMirrored = true
                }
            }
        }
        if movieFile!.isRecording {
            print("stop")
            movieFile?.stopRecording()
        }else{
            print("go")
            let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! + "/videoAudioCapture.mp4"
            let outputFileURL = URL(fileURLWithPath: path)
           movieFile?.startRecording(to: outputFileURL, recordingDelegate: self)
        }
    }
    
    @objc func gotoLocalFilePage(){
        let localFilePage = LocalFileListVC()
        navigationController?.pushViewController(localFilePage, animated: true)
    }
}

extension RecrodRoom:AVCaptureFileOutputRecordingDelegate {
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
//        print(error!)
        print("finish")
        recordIconButton.image = UIImage(named: "icRecordingStart")
    }
    
    func fileOutput(_ output: AVCaptureFileOutput, didStartRecordingTo fileURL: URL, from connections: [AVCaptureConnection]) {
        print("start")
        recordIconButton.image = UIImage(named: "icRecordingPause")
    }
}
