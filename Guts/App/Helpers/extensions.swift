//
//  extensions.swift
//  Guts
//
//  Created by chris on 30/8/19.
//  Copyright © 2019 mozat. All rights reserved.
//

import UIKit

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    static func rgba(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
}

extension UIView {
    func addConstraintsWidhFormat(format: String, views: UIView...){
        var viewsDictionary = [String: UIView]()
        
        for (index, view) in views.enumerated(){
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }
}

/*
 let label = UILabel()
 label.text = Iconfont.qq.rawValue
 label.font = UIFont.iconfont(ofSize: 18)
 */

extension UIFont {
    public class func iconfont(ofSize: CGFloat) -> UIFont? {
        return UIFont(name: "iconfont", size: ofSize)
    }
}

/*
 let imageView = UIImageView()
 CGSize(width: 30, height: 30)
 imageView.image = UIImage(text: Iconfont.qq, fontSize: 30, imageSize: CGSize(width: 30, height: 30), imageColor: UIColor.orange)
*/

extension UIImage {
    convenience init?(text: Iconfont, fontSize: CGFloat, imageSize: CGSize = CGSize.zero, imageColor: UIColor = UIColor.black) {
        guard let iconfont = UIFont.iconfont(ofSize: fontSize) else {
            self.init()
            return nil
        }
        var imageRect = CGRect(origin: CGPoint.zero, size: imageSize)
        if __CGSizeEqualToSize(imageSize, CGSize.zero) {
            imageRect = CGRect(origin: CGPoint.zero, size: text.rawValue.size(withAttributes: [NSAttributedString.Key.font: iconfont]))
        }
        UIGraphicsBeginImageContextWithOptions(imageRect.size, false, UIScreen.main.scale)
        defer {
            UIGraphicsEndImageContext()
        }
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.center
        let text_h = iconfont.lineHeight
        let text_y = (imageSize.height - text_h)/2
        let text_rect = CGRect(x:0, y: text_y, width: imageRect.size.width, height: text_h)
        text.rawValue.draw(in: text_rect.integral, withAttributes: [NSAttributedString.Key.font : iconfont, NSAttributedString.Key.paragraphStyle: paragraphStyle, NSAttributedString.Key.foregroundColor: imageColor])
        guard let cgImage = UIGraphicsGetImageFromCurrentImageContext()?.cgImage else {
            self.init()
            return nil
        }
        
        self.init(cgImage: cgImage)
    }
}
