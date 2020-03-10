//
//  UIVIew.swift
//  CandyTodo
//
//  Created by roman on 15.02.2020.
//  Copyright © 2020 ROMAN DOBYNDA. All rights reserved.
//

import UIKit

extension UIView {
    func debugLayout(color: UIColor = .red) {
        if self is UIStackView {
            let backgroundView = UIView()
            backgroundView.backgroundColor = color
            insertSubview(backgroundView, at: 0)
            backgroundView.snp.makeConstraints { (make) in
                make.edges.equalToSuperview()
            }
        } else {
            layer.borderWidth = 1
            layer.borderColor = color.cgColor
        }
    }
}
