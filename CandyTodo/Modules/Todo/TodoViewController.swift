//
//  TodoViewController.swift
//  CandyTodo
//
//  Created by roman on 17.02.2020.
//  Copyright © 2020 ROMAN DOBYNDA. All rights reserved.
//

import UIKit

final class TodoViewController: ViewController<TodoView> {

    private let todos = TodoData

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupTable()
    }

    // MARK: - SetupUI

    private func setupUI() {
        navigationItem.title = "TO-DO"
        customNavigationBar.barTintColor = Constants.Colors.background2

        setupSideMenuButton()
        setupSearchButton()
    }

    private func setupTable() {
        customView.tableView.delegate = self
        customView.tableView.dataSource = self
        customView.tableView.register(TodoCell.self, forCellReuseIdentifier: TodoCell.reuseIdentifier)
    }

    static func asNavigationController() -> NavigationController {
        let vc = Self()
        vc.tabBarItem = UITabBarItem(title: nil, image: Constants.Assets.listIcon.image, selectedImage: nil)
        let navVC = NavigationController(rootViewController: vc)
        return navVC
    }
}

// MARK: - UITableViewDataSource

extension TodoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // swiftlint:disable force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: TodoCell.reuseIdentifier) as! TodoCell
        // swiftlint:enable force_cast
        let task = todos[indexPath.row]
        cell.configure(task: task)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension TodoViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        customView.updateHeader(offsetY: scrollView.contentOffset.y)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
}
