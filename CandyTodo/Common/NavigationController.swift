//
//  NavigationController.swift
//  CandyTodo
//
//  Created by roman on 17.02.2020.
//  Copyright © 2020 ROMAN DOBYNDA. All rights reserved.
//

import UIKit
import SnapKit

final class NavigationController: UINavigationController {

    lazy var sideMenuViewController: SideMenuViewController = {
        return SideMenuViewController(parentViewController: self)
    }()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    // MARK: - SetupUI

    private func setupUI() {
        navigationBar.titleTextAttributes = [
            .kern: 4,
            .foregroundColor: Constants.Colors.primary,
            .font: Constants.Fonts.avenirBlack.size(14),
        ]
        navigationBar.isTranslucent = false
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
    }
}
