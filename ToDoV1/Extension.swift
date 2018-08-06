//
//  Extension.swift
//  ToDoV1
//
//  Created by Studio on 6/27/18.
//  Copyright © 2018 Son Avakian. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {



static let universalRed = UIColor().colorFromHex("e74c3c")
static let universalGreen = UIColor().colorFromHex("2980b9")
static let universalBackgroundColor = UIColor().colorFromHex("2c3e50")

func colorFromHex(_ hex : String) -> UIColor {
    
    var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if hexString.hasPrefix("#") {
        hexString.remove(at : hexString.startIndex)
    }
    
    if hexString.count != 6 {
        return UIColor.black
    }
    var rgb : UInt32 = 0
    Scanner(string: hexString).scanHexInt32(&rgb)
    return UIColor.init(red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
                        green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
                        blue: CGFloat(rgb & 0x0000FF) / 255.0,
                        alpha: 1.0)
}

}
