//
//  MainViewController.swift
//  CandyTodo
//
//  Created by roman on 13.02.2020.
//  Copyright © 2020 ROMAN DOBYNDA. All rights reserved.
//

import UIKit
import SnapKit

final class MainViewController: UITabBarController {

    override var selectedIndex: Int {
        willSet {
            moveIndicator(index: newValue)
        }
    }

    // MARK: - UI Elements

    private let middleViewController: UIViewController = {
        let viewController = UIViewController()
        let image = Constants.Assets.addIcon.image
        viewController.tabBarItem = UITabBarItem(title: nil, image: image, selectedImage: image)
        return viewController
    }()

    private var tabBarButtons: [UIView] {
        return tabBar.subviews.filter { $0.description.contains("Button") }
    }

    private var middleTabButton: UIView {
        return tabBarButtons[2]
    }

    private let indicator: UIView = {
        let view = UIView(frame: .zero)
        view.frame.size.height = 4
        view.backgroundColor = Constants.Colors.primary
        return view
    }()

    private let addButton: UIButton = {
        let button = UIButton()
        button.setImage(Constants.Assets.addIcon.image, for: .normal)
        return button
    }()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupControllers()
        setupUI()
        setupConstraints()
        setupActions()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        view.layoutIfNeeded()
        updateUI()
    }

    private func setupControllers() {
        viewControllers = [
            TodoViewController.asNavigationController(),
            SchedulerViewController.asNavigationController(),
            middleViewController,
            NotificationsViewController.asNavigationController(),
            ProfileViewController.asNavigationController(),
        ]
    }

    // MARK: - SetupUI

    private func setupUI() {
        if #available(iOS 13, *) {
            //
        } else {
            // Important! Call after init controller but before modifications tabBar
            for item in tabBar.items! {
                // iPhone Any / iOS 11 / Portrait & Landscape
                item.landscapeImagePhoneInsets.left = -10
                item.landscapeImagePhoneInsets.right = 10

                // iPad Air / iOS 11 / Portrait & Landscape
                if UIDevice.current.userInterfaceIdiom == .pad {
                    item.imageInsets.left = -10
                    item.imageInsets.right = 10
                }
            }
        }

        middleTabButton.isHidden = true
        tabBar.addSubview(indicator)
        delegate = self

        if #available(iOS 13.0.0, *) {
            let appr = UITabBarAppearance()
            appr.backgroundColor = Constants.Colors.background2
            appr.shadowColor = .clear
            for item in [appr.stackedLayoutAppearance, appr.inlineLayoutAppearance, appr.compactInlineLayoutAppearance] {
                item.normal.iconColor = Constants.Colors.secondary
                item.selected.iconColor = Constants.Colors.primary
            }
            tabBar.standardAppearance = appr
        } else {
            tabBar.backgroundColor = Constants.Colors.background2
            tabBar.shadowImage = UIImage()
            tabBar.backgroundImage = UIImage()
            tabBar.tintColor = Constants.Colors.primary
            tabBar.unselectedItemTintColor = Constants.Colors.secondary
        }

        tabBar.addSubview(addButton)
    }

    private func setupConstraints() {
        addButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
        }
    }

    private func setupActions() {
        addButton.addTarget(self, action: #selector(tapAddButton(_:)), for: .touchUpInside)
    }

    // MARK: - Actions

    @objc
    private func tapAddButton(_ sender: UIButton) {
        print(#function)
        let vc = NewTaskViewController()
        let navVC = NavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .formSheet
        present(navVC, animated: true)
    }

    // MARK: - UpdateUI

    private func updateUI() {
        updateShadow()
        moveIndicator(index: selectedIndex, duration: 0)
    }

    private func updateShadow() {
        let wh: CGFloat = 40
        let x = abs(addButton.frame.width / 2 - wh / 2)
        let y: CGFloat = 16 + wh / 3
        let rect = CGRect(x: x, y: y, width: wh, height: wh)

        addButton.layer.shadowColor = Constants.Colors.primary.cgColor
        addButton.layer.shadowPath = UIBezierPath(ovalIn: rect).cgPath
        addButton.layer.shadowOpacity = 0.4
        addButton.layer.shadowRadius = 8
    }

    private func moveIndicator(index: Int, duration: TimeInterval = 0.25) {
        let selectedButton = tabBarButtons[index]
        indicator.frame.size.width = tabBarButtons[0].frame.width + 4
        let point = CGPoint(
            x: selectedButton.center.x,
            y: selectedButton.frame.maxY - indicator.frame.height / 2
        )
        UIView.animate(withDuration: duration) { [weak self] in
            guard let self = self else { return }

            self.indicator.center = point
        }
    }
}

// MARK: - UITabBarControllerDelegate

extension MainViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard let index = viewControllers?.firstIndex(of: viewController) else {
            return false
        }

        if viewController == middleViewController {
            return false
        }

        moveIndicator(index: index)
        return true
    }
}

// MARK: - Preview SwiftUI

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct MainViewRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        return MainViewController().view
    }

    func updateUIView(_ view: UIView, context: Context) {
        //
    }
}

@available(iOS 13.0.0, *)
struct MainViewControllerPreview: PreviewProvider {
    static var previews: some View {
        Group {
            ForEach(PreviewDevices, id: \.self) { name in
                MainViewRepresentable()
                    .previewDevice(PreviewDevice(rawValue: name))
                    .previewDisplayName(name)
                    .edgesIgnoringSafeArea(.all)
            }
        }
    }
}
#endif
