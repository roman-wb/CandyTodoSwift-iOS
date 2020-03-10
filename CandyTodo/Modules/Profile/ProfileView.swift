//
//  ProfileView.swift
//  CandyTodo
//
//  Created by roman on 20.02.2020.
//  Copyright © 2020 ROMAN DOBYNDA. All rights reserved.
//

import UIKit
import SnapKit

final class ProfileView: UIView {

    // MARK: - UI Elements

    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.backgroundColor = .white
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.sectionFooterHeight = 16
        tableView.estimatedSectionFooterHeight = 16
        return tableView
    }()

    private var headerViewHeight: CGFloat = 112

    private var headerViewTopConstraint: Constraint!

    private let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(patternImage: Constants.Assets.headerBackground.image)
        return view
    }()

    private let avatarImageView: UIImageView = {
        let imageView = UIImageView(image: Constants.Assets.avatar.image)
        imageView.layer.cornerRadius = 56 / 2
        imageView.layer.masksToBounds = true
        return imageView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        let paragraphStyle = NSMutableParagraphStyle()
        label.attributedText = NSAttributedString(string: "Tiffany Schnewef", attributes: [
            .foregroundColor: Constants.Colors.primary,
            .font: Constants.Fonts.avenirBlack.size(24),
            .paragraphStyle: paragraphStyle,
        ])
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        return label
    }()

    private let emailLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "tiffany.s@email.com", attributes: [
            .foregroundColor: Constants.Colors.primary,
            .font: Constants.Fonts.avenirBook.size(12),
        ])
        return label
    }()

    // MARK: - Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - SetupUI

    private func setupUI() {
        tableView.contentInset.top = headerViewHeight
        tableView.contentOffset.y = -headerViewHeight
        tableView.fallbackVerticalScrollIndicatorInsets.top = headerViewHeight

        addSubview(tableView)
        addSubview(headerView)
            headerView.addSubview(avatarImageView)
            headerView.addSubview(nameLabel)
            headerView.addSubview(emailLabel)
    }

    private func setupConstraints() {
        avatarImageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 56, height: 56))
            make.leading.equalTo(safeAreaLayoutGuide).offset(32)
        }

        nameLabel.snp.makeConstraints { (make) in
            make.height.equalTo(27)
            make.top.equalTo(32)
            make.leading.equalTo(safeAreaLayoutGuide).offset(120)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-32)
        }

        emailLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(safeAreaLayoutGuide).offset(120)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-32)
            make.bottom.equalTo(-32)
        }

        headerView.snp.makeConstraints { (make) in
            headerViewTopConstraint = make.top.equalToSuperview().constraint
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(headerViewHeight)
        }

        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

    // MARK: - UpdateUI

    func updateHeader(offsetY: CGFloat) {
        if offsetY < -headerViewHeight {
            headerViewTopConstraint.update(offset: 0)
        } else if offsetY <= 0 {
            headerViewTopConstraint.update(offset: abs(offsetY) - headerViewHeight)
        } else {
            headerViewTopConstraint.update(offset: -headerViewHeight)
        }
    }
}
