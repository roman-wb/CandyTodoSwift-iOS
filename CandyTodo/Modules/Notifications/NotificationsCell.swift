//
//  NotificationsCell.swift
//  CandyTodo
//
//  Created by roman on 19.02.2020.
//  Copyright © 2020 ROMAN DOBYNDA. All rights reserved.
//

import UIKit

final class NotificationsCell: UITableViewCell {

    // MARK: - UI Elements

    private let infoImageView: UIImageView = {
        return UIImageView(image: Constants.Assets.notifyIcon.image)
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

    func configure(notify: Notify) {
        titleLabel.attributedText = NSAttributedString(string: notify.title, attributes: [
            .foregroundColor: Constants.Colors.primary,
            .font: Constants.Fonts.avenirBook.size(12),
        ])
    }

    // MARK: - SetupUI

    private func setupUI() {
        addSubview(infoImageView)
        addSubview(titleLabel)
    }

    private func setupConstraints() {
        infoImageView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 24, height: 24))
            make.top.equalTo(16)
            make.leading.equalTo(safeAreaLayoutGuide).offset(32)
            make.bottom.lessThanOrEqualTo(-16)
        }

        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.top.greaterThanOrEqualTo(16)
            make.leading.equalTo(safeAreaLayoutGuide).offset(80)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-20)
            make.bottom.lessThanOrEqualTo(-16)
        }
    }
}
