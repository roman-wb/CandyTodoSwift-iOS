//
//  UIWindow+Extension.swift
//  CandyTodo
//
//  Created by roman on 05.03.2020.
//  Copyright © 2020 ROMAN DOBYNDA. All rights reserved.
//

import UIKit

extension UIWindow {
    static var keyWindow: UIWindow? {
        if #available(iOS 13, *) {
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }

    static func transitionTo(viewController: UIViewController) {
        guard let window = UIWindow.keyWindow else {
            return
        }

        window.rootViewController = viewController

        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
    }
}
