//
//  ScrollView.swift
//  CandyTodo
//
//  Created by roman on 02.03.2020.
//  Copyright © 2020 ROMAN DOBYNDA. All rights reserved.
//

import UIKit

class ScrollView: UIScrollView {

    // MARK: - Properties

    var keyboardRect: CGRect = .zero

    var topOffset: CGFloat {
        return contentOffset.y
    }

    var bottomOffset: CGFloat {
        return totalSize - bounds.height - contentOffset.y
    }

    var isOverflowHeight: Bool {
        return totalSize > bounds.height
    }

    var totalSize: CGFloat {
        return contentSize.height + contentInset.top + contentInset.bottom
    }

    // MARK: - Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardDidShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Actions

    @objc
    func keyboardDidShow(_ notification: Notification) {
        guard
            let userInfo = notification.userInfo,
            let frame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
            else {
                return
        }

        keyboardRect = frame.cgRectValue
    }

    @objc
    func keyboardWillHide(_ notification: Notification) {
        keyboardRect = .zero
    }

    deinit {
       NotificationCenter.default.removeObserver(self)
    }
}
