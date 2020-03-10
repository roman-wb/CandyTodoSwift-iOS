//
//  SideMenuView.swift
//  CandyTodo
//
//  Created by roman on 26.02.2020.
//  Copyright © 2020 ROMAN DOBYNDA. All rights reserved.
//

import UIKit

final class SideMenuView: UIView {

    // MARK: - UI Elements

    let sideView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.allowsSelection = true
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        return tableView
    }()

    private let headerView: UIView = {
        return UIView()
    }()

    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.Colors.primary.withAlphaComponent(0.2)
        return view
    }()

    private let avatarImageView: UIImageView = {
        let imageView = UIImageView(image: Constants.Assets.avatar.image)
        imageView.layer.cornerRadius = 32 / 2
        imageView.layer.masksToBounds = true
        return imageView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "Tiffany", attributes: [
            .foregroundColor: Constants.Colors.primary,
            .font: Constants.Fonts.avenirBlack.size(24),
        ])
        return label
    }()

    private let footerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    private let copyrightLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "© 2017 Candy", attributes: [
            .foregroundColor: Constants.Colors.secondary,
            .font: Constants.Fonts.avenirBook.size(12),
        ])
        return label
    }()

    // MARK: - Life Cycle

    override func layoutSubviews() {
        super.layoutSubviews()

        sideView.layer.shadowColor = Constants.Colors.background2.cgColor
        sideView.layer.shadowOffset = CGSize(width: 4, height: 0)
        sideView.layer.shadowOpacity = 1
        sideView.layer.shadowRadius = 24 / 2
    }

    func setup() {
        setupUI()
        setupConstraints()
    }

    // MARK: - SetupUI

    private func setupUI() {
        addSubview(sideView)
            sideView.addSubview(tableView)
            sideView.addSubview(headerView)
                headerView.addSubview(separatorView)
                headerView.addSubview(avatarImageView)
                headerView.addSubview(nameLabel)
            sideView.addSubview(footerView)
                footerView.addSubview(copyrightLabel)
    }

    private func setupConstraints() {
        snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

        sideView.snp.makeConstraints { (make) in
            make.top.leading.bottom.equalToSuperview()
            make.width.equalTo(300)
        }

        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(safeAreaLayoutGuide).offset(97)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(-56)
        }

        headerView.snp.makeConstraints { (make) in
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.trailing.equalTo(tableView)
            make.height.equalTo(97)
        }

        separatorView.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(1)
        }

        avatarImageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalTo(32)
            make.size.equalTo(CGSize(width: 32, height: 32))
        }

        nameLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalTo(81)
            make.trailing.equalTo(-32)
        }

        footerView.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(tableView)
            make.bottom.equalToSuperview()
            make.height.equalTo(56)
        }

        copyrightLabel.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 20, left: 32, bottom: 20, right: 32))
        }
    }

    // MARK: - UpdateUI

    private var inProgress = false

    func show() {
        if inProgress { return }

        inProgress = true
        isHidden = false
        frame.origin.x = -UIScreen.main.bounds.width

        UIView.animate(withDuration: 0.25, delay: 0, options: [], animations: { [weak self] in
           self?.frame.origin.x = 0
        }, completion: { [weak self] (_) in
            self?.inProgress = false
        })
    }

    func hide(completion: (() -> Void)? = nil) {
        if inProgress { return }

        inProgress = true

        UIView.animate(withDuration: 0.25, delay: 0, options: [], animations: { [weak self] in
           self?.frame.origin.x = -UIScreen.main.bounds.width
        }, completion: { [weak self] (_) in
            completion?()
            self?.isHidden = true
            self?.inProgress = false
        })
    }
}
