//
//  UIScrollView+Extension.swift
//  CandyTodo
//
//  Created by roman on 06.03.2020.
//  Copyright © 2020 ROMAN DOBYNDA. All rights reserved.
//

import UIKit

extension UIScrollView {
    var fallbackVerticalScrollIndicatorInsets: UIEdgeInsets {
        set {
            if #available(iOS 11.1, *) {
                self.verticalScrollIndicatorInsets = newValue
            } else {
                self.scrollIndicatorInsets = newValue
            }
        }
        get {
            if #available(iOS 11.1, *) {
                return self.verticalScrollIndicatorInsets
            } else {
                return self.scrollIndicatorInsets
            }
        }
    }
}
