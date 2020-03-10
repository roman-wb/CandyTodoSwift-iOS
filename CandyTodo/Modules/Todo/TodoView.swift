//
//  TodayView.swift
//  CandyTodo
//
//  Created by roman on 20.02.2020.
//  Copyright © 2020 ROMAN DOBYNDA. All rights reserved.
//

import UIKit
import SnapKit

final class TodoView: UIView {

    // MARK: - UI Elements

    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.backgroundColor = .white
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = UITableView.automaticDimension
        tableView.sectionFooterHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        return tableView
    }()

    private var headerViewHeight: CGFloat = 112

    private var headerViewTopConstraint: Constraint!

    private let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(patternImage: Constants.Assets.headerBackground.image)
        view.frame.size.width = UIScreen.main.bounds.width
        view.frame.size.height = 112
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.attributedText = NSAttributedString(string: "Today’s\nlist —", attributes: [
            .foregroundColor: Constants.Colors.primary,
            .font: Constants.Fonts.avenirBlack.size(24),
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
            headerView.addSubview(titleLabel)
    }

    private func setupConstraints() {
        headerView.snp.makeConstraints { (make) in
            headerViewTopConstraint = make.top.equalToSuperview().constraint
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(headerViewHeight)
        }

        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalTo(safeAreaLayoutGuide).offset(32)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-32)
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
