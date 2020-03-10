//
//  NotificationsViewController.swift
//  CandyTodo
//
//  Created by roman on 17.02.2020.
//  Copyright © 2020 ROMAN DOBYNDA. All rights reserved.
//

import UIKit
import SnapKit

final class NotificationsViewController: ViewController<NotificationsView> {

    private let tasks = NotificationsData

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupTable()
    }

    // MARK: - SetupUI

    private func setupUI() {
        navigationItem.title = "NOTIFICATIONS"
        customNavigationBar.barTintColor = Constants.Colors.background2

        setupSideMenuButton()
        setupSearchButton()
    }

    private func setupTable() {
        customView.tableView.delegate = self
        customView.tableView.dataSource = self
        customView.tableView.register(NotificationsCell.self, forCellReuseIdentifier: NotificationsCell.reuseIdentifier)
    }

    static func asNavigationController() -> NavigationController {
        let vc = Self()
        vc.tabBarItem = UITabBarItem(title: nil, image: Constants.Assets.clockIcon.image, selectedImage: nil)
        let navVC = NavigationController(rootViewController: vc)
        return navVC
    }
}

// MARK: - UITableViewDataSource

extension NotificationsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        tasks.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks[section].notifies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // swiftlint:disable force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: NotificationsCell.reuseIdentifier) as! NotificationsCell
        // swiftlint:enable force_cast
        let notify = tasks[indexPath.section].notifies[indexPath.row]
        cell.configure(notify: notify)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension NotificationsViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        customView.updateHeader(offsetY: scrollView.contentOffset.y)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return NotificationsSectionHeaderView(title: tasks[section].title)
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
