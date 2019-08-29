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
    
    @IBAction func sendOtp(_ sender: UIButton) {
    }
    
    @IBAction func selectAreaCode(_ sender: Any) {
        let areaCodeVc = AreaCodeViewController()
        areaCodeVc.delgete = self
        navigationController?.pushViewController(areaCodeVc, animated: true)
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
        logger.log(params)
        areaCode.setTitle("+\(params)", for: .normal)
    }
}




