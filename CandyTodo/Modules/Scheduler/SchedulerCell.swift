//
//  SchedulerCell.swift
//  CandyTodo
//
//  Created by roman on 19.02.2020.
//  Copyright © 2020 ROMAN DOBYNDA. All rights reserved.
//

import UIKit

final class SchedulerCell: UITableViewCell {

    private var task: Task!

    // MARK: - UI Elements

    private let toggleButton: UIButton = {
        return UIButton()
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
        setupActions()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(task: Task) {
        self.task = task

        updateUI()
    }

    // MARK: - SetupUI

    private func setupUI() {
        addSubview(toggleButton)
        addSubview(titleLabel)
    }

    private func setupConstraints() {
        toggleButton.snp.makeConstraints { (make) in
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

    // MARK: - Actions

    private func setupActions() {
        toggleButton.addTarget(self, action: #selector(tapToggleButton(_:)), for: .touchUpInside)
    }

    @objc
    private func tapToggleButton(_ button: UIButton) {
        task.done.toggle()

        updateUI()
    }

    // MARK: - UpdateUI

    private func updateUI() {
        var attributes: [NSAttributedString.Key: Any] = [
            .font: Constants.Fonts.avenirBook.size(12),
        ]

        if task.done {
            attributes[.foregroundColor] = Constants.Colors.secondary
            toggleButton.setImage(Constants.Assets.checkedIcon.image, for: .normal)
        } else {
            attributes[.foregroundColor] = Constants.Colors.primary
            toggleButton.setImage(Constants.Assets.uncheckedIcon.image, for: .normal)
        }

        titleLabel.attributedText = NSAttributedString(string: task.title, attributes: attributes)
    }
}
