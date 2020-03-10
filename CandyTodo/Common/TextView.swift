//
//  TextView.swift
//  CandyTodo
//
//  Created by roman on 25.02.2020.
//  Copyright © 2020 ROMAN DOBYNDA. All rights reserved.
//

import UIKit

class TextView: UITextView {
    let placeholderLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    override var contentSize: CGSize {
        didSet {
            let topCorrection = (bounds.size.height - contentSize.height * zoomScale) / 2.0
            contentInset.top = max(0, topCorrection)
        }
    }

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)

        delegate = self

        addSubview(placeholderLabel)

        placeholderLabel.snp.makeConstraints { (make) in
            make.top.equalTo(8)
            make.leading.equalTo(5)
            make.trailing.bottom.equalToSuperview()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TextView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = text.count != 0
    }
}
