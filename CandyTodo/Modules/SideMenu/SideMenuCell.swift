//
//  SideMenuCell.swift
//  CandyTodo
//
//  Created by roman on 19.02.2020.
//  Copyright © 2020 ROMAN DOBYNDA. All rights reserved.
//

import UIKit

final class SideMenuCell: UITableViewCell {

    // MARK: - UI Elements

    private let titleLabel: UILabel = {
        let label = UILabel()
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
        let color = title == "Logout" ? Constants.Colors.secondary : Constants.Colors.primary

        titleLabel.attributedText = NSAttributedString(string: title, attributes: [
            .foregroundColor: color,
            .font: Constants.Fonts.avenirBook.size(12),
        ])
    }

    // MARK: - SetupUI

    private func setupUI() {
        selectionStyle = .none

        addSubview(titleLabel)
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.edges.equalTo(UIEdgeInsets(top: 20, left: 32, bottom: 20, right: 32))
        }
    }
}
