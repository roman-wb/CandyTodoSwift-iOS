//
//  SchedulerSectionHeaderView.swift
//  CandyTodo
//
//  Created by roman on 21.02.2020.
//  Copyright © 2020 ROMAN DOBYNDA. All rights reserved.
//

import UIKit

final class SchedulerSectionHeaderView: UIView {

    private let title: String

    // MARK: - UI Elements

    private let titleLabel: UILabel = {
        return UILabel()
    }()

    // MARK: - Life Cycle

    init(title: String) {
        self.title = title

        super.init(frame: .zero)

        setupUI()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - SetupUI

    private func setupUI() {
        titleLabel.attributedText = NSAttributedString(string: title, attributes: [
            .foregroundColor: Constants.Colors.secondary,
            .font: Constants.Fonts.avenirBook.size(12),
        ])

        addSubview(titleLabel)
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(16)
            make.leading.equalTo(safeAreaLayoutGuide).offset(32)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-32)
            make.bottom.equalToSuperview()
        }
    }
}
