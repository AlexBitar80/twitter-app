//
//  UIColor+Extensions.swift
//  twitter-app-view-code
//
//  Created by João Alexandre on 28/05/22.
//

import Foundation
import UIKit

extension UIColor {
    static let blueTwitter = UIColor.rgb(red: 29, green: 161, blue: 242)
    
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}
