//
//  ProfileCell.swift
//  CandyTodo
//
//  Created by roman on 19.02.2020.
//  Copyright © 2020 ROMAN DOBYNDA. All rights reserved.
//

import UIKit

final class ProfileCell: UITableViewCell {

    // MARK: - UI Elements

    private let toggleSwitch: UISwitch = {
        let button = UISwitch()
        button.backgroundColor = .white
        button.tintColor = .white
        button.onTintColor = Constants.Colors.borderSwitch
        if #available(iOS 13, *) {
            if let subview = button.subviews.first?.subviews.first {
                subview.backgroundColor = .white
            }
        }
        button.layer.masksToBounds = true
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = 16.0
        button.layer.borderColor = Constants.Colors.borderSwitch.cgColor
        return button
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()

    // MARK: - Life Cycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupUI()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(title: String) {
        titleLabel.attributedText = NSAttributedString(string: title, attributes: [
            .foregroundColor: Constants.Colors.primary,
            .font: Constants.Fonts.avenirBook.size(12),
        ])
    }

    // MARK: - SetupUI

    private func setupUI() {
        addSubview(titleLabel)
        addSubview(toggleSwitch)
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.top.greaterThanOrEqualTo(13)
            make.leading.equalTo(safeAreaLayoutGuide).offset(32)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-85)
            make.bottom.lessThanOrEqualTo(-12)
        }

        toggleSwitch.snp.makeConstraints { (make) in
            make.top.equalTo(13)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-32)
            make.bottom.lessThanOrEqualTo(-12)
        }
    }
}
