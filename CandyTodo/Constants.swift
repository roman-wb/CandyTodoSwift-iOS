//
//  Constraints.swift
//  CandyTodo
//
//  Created by roman on 15.02.2020.
//  Copyright © 2020 ROMAN DOBYNDA. All rights reserved.
//

import UIKit

enum Constants {

    enum Colors {
        // login & register background
        static let background1 = UIColor(rgb: 0xFFEDEE)

        // login & register text field border
        // tabBar & navBar background
        static let background2 = UIColor(rgb: 0xFFE5E5)

        // primary text color (as blue)
        static let primary = UIColor(rgb: 0x243B6B)

        // secondary text color (as gray)
        static let secondary = UIColor(rgb: 0x243B6B).withAlphaComponent(0.5)

        // border text field
        static let borderField = UIColor(rgb: 0x243B6B).withAlphaComponent(0.3)

        // on switch background color
        static let borderSwitch = UIColor(rgb: 0x93FFDF)
    }

    enum Fonts: String {
        case avenirBlack    = "Avenir-Black"
        case avenirBook     = "Avenir-Book"
        case avenirMedium   = "Avenir-Medium"
        case avenirHeavy    = "Avenir-Heavy"

        func size(_ size: CGFloat) -> UIFont {
            return UIFont(name: rawValue, size: size)!
        }
    }

    enum Assets: String {
        case eyeIcon
        case menuIcon
        case searchIcon
        case addIcon
        case saveIcon
        case closeIcon
        case editIcon
        case listIcon
        case clockIcon
        case bellIcon
        case userIcon
        case checkedIcon
        case uncheckedIcon
        case notifyIcon
        case headerBackground
        case avatar

        var image: UIImage {
            return UIImage(named: rawValue)!
        }
    }
}
