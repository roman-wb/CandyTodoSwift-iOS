//
//  SideMenuViewController.swift
//  CandyTodo
//
//  Created by roman on 26.02.2020.
//  Copyright © 2020 ROMAN DOBYNDA. All rights reserved.
//

import UIKit

final class SideMenuViewController: ViewController<SideMenuView> {

    private let items = MenuData

    private weak var parentVC: UINavigationController?

    // MARK: - Life Cycle

    init(parentViewController: UINavigationController) {
        super.init(nibName: nil, bundle: nil)

        self.parentVC = parentViewController

        if let window = UIWindow.keyWindow {
            window.addSubview(view)
            customView.setup()
        }

        setupTableView()
        setupActions()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - SetupUI

    private func setupTableView() {
        customView.tableView.delegate = self
        customView.tableView.dataSource = self
        customView.tableView.register(SideMenuCell.self, forCellReuseIdentifier: SideMenuCell.reuseIdentifier)
    }

    // MARK: - Actions

    private func setupActions() {
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(hideSideMenu(_:)))
        tapGesture.delegate = self
        view.addGestureRecognizer(tapGesture)

        let swipeGesture = UISwipeGestureRecognizer()
        swipeGesture.direction = .left
        tapGesture.delegate = self
        swipeGesture.addTarget(self, action: #selector(hideSideMenu))
        view.addGestureRecognizer(swipeGesture)
    }

    @objc
    private func hideSideMenu(_ gesture: UITapGestureRecognizer) {
        customView.hide()
    }
}

// MARK: - UIGestureRecognizerDelegate

extension SideMenuViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        let location = touch.location(in: view)
        if customView.tableView.frame.contains(location) {
            return false
        }
        return true
    }
}

// MARK: - UITableViewDataSource

extension SideMenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0...1:
            customView.hide { [weak self] in
                self?.parentVC?.tabBarController?.selectedIndex = indexPath.row
            }
        case 2...3:
            customView.hide { [weak self] in
                self?.parentVC?.tabBarController?.selectedIndex = indexPath.row + 1
            }
        case 4:
            UIWindow.transitionTo(viewController: LoginViewController.asNavigationController())
        default:
            break
        }
    }
}

// MARK: - UITableViewDataSource

extension SideMenuViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // swiftlint:disable force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: SideMenuCell.reuseIdentifier) as! SideMenuCell
        // swiftlint:enable force_cast
        let title = items[indexPath.row]
        cell.configure(title: title)
        return cell
    }
}
