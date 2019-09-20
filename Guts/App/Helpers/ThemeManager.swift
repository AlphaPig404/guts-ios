//
//  ThemeManager.swift
//  Guts
//
//  Created by chris on 6/9/19.
//  Copyright © 2019 mozat. All rights reserved.
//

import Foundation
import UIKit

enum Theme: Int {
    case theme1, theme2
    
    var mainColor: UIColor{
        switch self {
        case .theme1:
            return UIColor.rgb(red: 0, green: 0, blue: 0)
        case .theme2:
            return UIColor.rgb(red: 255, green: 255, blue: 255)
        }
    }
    
    var barStyle: UIBarStyle{
        switch self {
        case .theme1:
            return .default
        case .theme2:
            return .black
        }
    }
    
    var navigationBackgroundImage: UIImage? {
        return self == .theme1 ? UIImage(named: "navBackground") : nil
    }
    
    var tabBarBackGroundImage: UIImage? {
        return self == .theme1 ? UIImage(named: "tabBarBackground") : nil
    }
    
    var backgroundColor: UIColor{
        switch self {
        case .theme1:
            return UIColor.rgb(red: 0, green: 0, blue: 0)
        case .theme2:
            return UIColor.rgb(red: 255, green: 255, blue: 255)
        }
    }
    
    var secondaryColor: UIColor{
        switch self {
        case .theme1:
            return UIColor.rgb(red: 0, green: 0, blue: 0)
        case .theme2:
            return UIColor.rgb(red: 255, green: 255, blue: 255)
        }
    }
    
    var titleTextColor: UIColor{
        switch self {
        case .theme1:
            return UIColor.rgb(red: 0, green: 0, blue: 0)
        case .theme2:
            return UIColor.rgb(red: 255, green: 255, blue: 255)
        }
    }
    
    var subtitleTextColor: UIColor{
        switch self {
        case .theme1:
            return UIColor.rgb(red: 0, green: 0, blue: 0)
        case .theme2:
            return UIColor.rgb(red: 255, green: 255, blue: 255)
        }
    }
}

let SelectedThemeKey = "SelectedTheme"

class ThemeManager {
//    static func currentTheme() -> Theme {
//        if let storedTheme = (UserDefaults.standard.value(forKey: SelectedThemeKey) as AnyObject){
//            return Theme(rawValue: storedTheme)!
//        }else{
//            return .theme2
//        }
//    }
}

