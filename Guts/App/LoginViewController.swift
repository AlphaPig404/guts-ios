//
//  ViewController.swift
//  LoopsChallenge
//
//  Created by uncle_jia on 17/7/19.
//  Copyright © 2019 mozat. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController{
    @IBOutlet weak var phoneNumContainer: UIView!
    @IBOutlet weak var otpField: TextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var areaCode: UIButton!
    
    @IBAction func confrimLogin(_ sender: UIButton) {
        let homeViewCotroller = HomeViewController()
        navigationController?.pushViewController(homeViewCotroller, animated: true)
    }
    
    @IBAction func sendOtp(_ sender: Any) {
        print(phoneField.text)
        print(areaCode.titleLabel?.text)
    }   
    
    
    @IBAction func selectAreaCode(_ sender: Any) {
        let areaCodeVC = AreaCodeViewController()
        // 在这种情况下没有引用循环 没有必要【weak self】
        areaCodeVC.delgete = self
        areaCodeVC.showDetailClousrue = { area in
            logger.log("area ---> \(area)")
            return
        }

        navigationController?.pushViewController(areaCodeVC, animated: true)
    }
    
    @IBAction func nav2Register(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    func initView(){
        phoneNumContainer.layer.borderColor = UIColor.init(displayP3Red: 255, green: 255, blue: 255, alpha: 0.2).cgColor
        otpField.layer.borderColor = UIColor.init(displayP3Red: 255, green: 255, blue: 255, alpha: 0.2).cgColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

extension LoginViewController: ReturnValueDelegate{
    func returnValue(params: String) {
        
        areaCode.setTitle("+\(params)", for: .normal)
    }
}




