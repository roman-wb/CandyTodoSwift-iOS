//
//  ViewController.swift
//  CandyTodo
//
//  Created by roman on 28.02.2020.
//  Copyright © 2020 ROMAN DOBYNDA. All rights reserved.
//

import UIKit

class ViewController<View: UIView>: UIViewController {

    // MARK: - Properties

    var customNavigationController: NavigationController {
        // swiftlint:disable force_cast
        return navigationController as! NavigationController
        // swiftlint:enable force_cast
    }

    var customNavigationBar: UINavigationBar {
        return navigationController!.navigationBar
    }

    var customTabBarController: MainViewController {
        // swiftlint:disable force_cast
        return tabBarController as! MainViewController
        // swiftlint:enable force_cast
    }

    var customView: View {
        // swiftlint:disable force_cast
        return view as! View
        // swiftlint:enable force_cast
    }

     // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view = View()
    }

    // MARK: - SetupUI

    func setupSideMenuButton() {
        let barButtonItem = UIBarButtonItem(image: Constants.Assets.menuIcon.image,
                                        style: .plain,
                                        target: self,
                                        action: #selector(tapShowSideMenu(_:)))
        barButtonItem.tintColor = Constants.Colors.primary
        navigationItem.leftBarButtonItem = barButtonItem
    }

    func setupSearchButton() {
        let barButtonItem = UIBarButtonItem(image: Constants.Assets.searchIcon.image,
                                        style: .plain,
                                        target: self,
                                        action: #selector(tapSearch(_:)))
        barButtonItem.tintColor = Constants.Colors.primary
        navigationItem.rightBarButtonItem = barButtonItem
    }

    // MARK: - Actions

    @objc
    private func tapShowSideMenu(_ sender: Any) {
        customNavigationController.sideMenuViewController.customView.show()
    }

    @objc
    private func tapSearch(_ sender: Any) {
        print(#function)
    }
}
