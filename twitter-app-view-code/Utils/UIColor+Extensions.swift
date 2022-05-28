//
//  UIColor+Extensions.swift
//  twitter-app-view-code
//
//  Created by João Alexandre on 28/05/22.
//

import Foundation
import UIKit

extension UIColor {
    static let blueTwitter = UIColor(red: 0.11, green: 0.63, blue: 0.95, alpha: 1.00)
    
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}
