//
//  ProgressBar.swift
//  Guts
//
//  Created by chris on 2/9/19.
//  Copyright © 2019 mozat. All rights reserved.
//

import Foundation
import UIKit

class ProgressBar: UIView{
    let  progressView: UIProgressView = {
        let pv = UIProgressView(progressViewStyle: .default)
        pv.progress = 0.5
        pv.layer.cornerRadius = 4
        pv.clipsToBounds = true
        pv.progressTintColor = UIColor.rgb(red: 244, green: 249, blue: 151)
        return pv
    }()
    
    let currentLabel: UILabel = {
        let lv = UILabel()
        lv.text = "0"
        lv.textColor = UIColor.white
        lv.font = UIFont.systemFont(ofSize: 10)
        return lv
    }()
    
    let limitLabel: UILabel = {
        let lv = UILabel()
        lv.text = "60"
        lv.textColor = UIColor.white
        lv.font = UIFont.systemFont(ofSize: 10)
        return lv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubView(){
       self.addSubview(progressView)
       self.addSubview(currentLabel)
       self.addSubview(limitLabel)
    }
    
    override func layoutSubviews() {
        progressView.snp_makeConstraints{
            $0.centerY.equalToSuperview()
            $0.left.right.top.equalToSuperview()
            $0.height.equalTo(8)
        }
        currentLabel.snp_makeConstraints{
            $0.leading.equalTo(progressView)
            $0.top.equalTo(progressView.snp_bottom).offset(4)
        }
        limitLabel.snp_makeConstraints{
            $0.trailing.equalTo(progressView)
            $0.top.equalTo(progressView.snp_bottom).offset(4)
        }
    }
}
