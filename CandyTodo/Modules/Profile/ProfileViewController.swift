//
//  ProfileViewController.swift
//  CandyTodo
//
//  Created by roman on 17.02.2020.
//  Copyright © 2020 ROMAN DOBYNDA. All rights reserved.
//

import UIKit
import SnapKit

final class ProfileViewController: ViewController<ProfileView> {

    private let settings = SettingsData

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupTable()
    }

    // MARK: - SetupUI

    private func setupUI() {
        navigationItem.title = "PROFILE"
        customNavigationBar.barTintColor = Constants.Colors.background2

        setupSideMenuButton()
        let editBarButtonItem = UIBarButtonItem(image: Constants.Assets.editIcon.image,
                                                style: .plain,
                                                target: self,
                                                action: #selector(tapEditProfileButton(_:)))
        editBarButtonItem.tintColor = Constants.Colors.primary
        navigationItem.rightBarButtonItem = editBarButtonItem

        customView.tableView.delegate = self
        customView.tableView.dataSource = self
        customView.tableView.register(ProfileCell.self, forCellReuseIdentifier: ProfileCell.reuseIdentifier)
    }

    private func setupTable() {
        customView.tableView.delegate = self
        customView.tableView.dataSource = self
        customView.tableView.register(NotificationsCell.self, forCellReuseIdentifier: NotificationsCell.reuseIdentifier)
    }

    static func asNavigationController() -> NavigationController {
        let vc = Self()
        vc.tabBarItem = UITabBarItem(title: nil, image: Constants.Assets.userIcon.image, selectedImage: nil)
        let navVC = NavigationController(rootViewController: vc)
        return navVC
    }

    // MARK: - Actions

    @objc
    private func tapEditProfileButton(_ sender: Any) {
        print(#function)
        let vc = EditProfileViewController()
        let navVC = NavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .formSheet
        present(navVC, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension ProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        settings.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings[section].items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // swiftlint:disable force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileCell.reuseIdentifier) as! ProfileCell
        // swiftlint:enable force_cast
        let title = settings[indexPath.section].items[indexPath.row]
        cell.configure(title: title)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ProfileViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        customView.updateHeader(offsetY: scrollView.contentOffset.y)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return ProfileSectionHeaderView(title: settings[section].title)
    }
}
