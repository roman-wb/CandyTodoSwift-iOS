//
//  SchedulerViewController.swift
//  CandyTodo
//
//  Created by roman on 17.02.2020.
//  Copyright © 2020 ROMAN DOBYNDA. All rights reserved.
//

import UIKit
import SnapKit

final class SchedulerViewController: ViewController<SchedulerView> {

    private let tasks = SchedulerData

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupTable()
    }

    // MARK: - SetupUI

    private func setupUI() {
        navigationItem.title = "SCHEDULER"
        customNavigationBar.barTintColor = Constants.Colors.background2

        setupSideMenuButton()
        setupSearchButton()
    }

    private func setupTable() {
        customView.tableView.delegate = self
        customView.tableView.dataSource = self
        customView.tableView.register(SchedulerCell.self, forCellReuseIdentifier: SchedulerCell.reuseIdentifier)
    }

    static func asNavigationController() -> NavigationController {
        let vc = Self()
        vc.tabBarItem = UITabBarItem(title: nil, image: Constants.Assets.clockIcon.image, selectedImage: nil)
        let navVC = NavigationController(rootViewController: vc)
        return navVC
    }
}

// MARK: - UITableViewDataSource

extension SchedulerViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        tasks.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks[section].tasks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // swiftlint:disable force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: SchedulerCell.reuseIdentifier) as! SchedulerCell
        // swiftlint:enable force_cast
        let task = tasks[indexPath.section].tasks[indexPath.row]
        cell.configure(task: task)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension SchedulerViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        customView.updateHeader(offsetY: scrollView.contentOffset.y)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return SchedulerSectionHeaderView(title: tasks[section].title)
    }
}
