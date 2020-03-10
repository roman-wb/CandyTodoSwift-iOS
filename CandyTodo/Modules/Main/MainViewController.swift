//
//  MainViewController.swift
//  CandyTodo
//
//  Created by roman on 13.02.2020.
//  Copyright © 2020 ROMAN DOBYNDA. All rights reserved.
//

import UIKit
import SnapKit

class TabBar: UITabBar {

    // MARK: - UI elements

    let middleButton: UIButton = {
        let button = UIButton()
        button.setImage(Constants.Assets.addIcon.image, for: .normal)
        return button
    }()

    private let indicator: UIView = {
        let view = UIView(frame: .zero)
        view.frame.size.height = 4
        view.backgroundColor = Constants.Colors.primary
        return view
    }()

    private var buttons: [UIView] {
        return subviews.filter { $0.description.contains("UITabBarButton") }
    }

    // MARK: - Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if middleButton.frame.contains(point) {
            return middleButton
        } else {
            return super.hitTest(point, with: event)
        }
    }

    // MARK: - SetupUI

    private func setupUI() {
        addSubview(middleButton)
        addSubview(indicator)

        if #available(iOS 13.0.0, *) {
            let appr = UITabBarAppearance()
            appr.backgroundColor = Constants.Colors.background2
            appr.shadowColor = .clear
            for item in [appr.stackedLayoutAppearance, appr.inlineLayoutAppearance, appr.compactInlineLayoutAppearance] {
                item.normal.iconColor = Constants.Colors.secondary
                item.selected.iconColor = Constants.Colors.primary
            }
            standardAppearance = appr
        } else {
            backgroundColor = Constants.Colors.background2
            shadowImage = UIImage()
            backgroundImage = UIImage()
            tintColor = Constants.Colors.primary
            unselectedItemTintColor = Constants.Colors.secondary
        }
    }

    private func setupConstraints() {
        middleButton.snp.makeConstraints { (make) in
           make.centerX.equalToSuperview()
           make.bottom.equalTo(safeAreaLayoutGuide).offset(-10)
       }
    }

    // MARK: - UpdateUI

    func updateUI() {
        updateShadow()
        updateIconPosition()
    }

    func updateIndicator(index: Int, duration: TimeInterval = 0.25) {
        let selectedButton = buttons[index]
        indicator.frame.size.width = buttons[0].frame.width + 4
        let point = CGPoint(
            x: selectedButton.center.x,
            y: selectedButton.frame.maxY - indicator.frame.height / 2
        )
        UIView.animate(withDuration: duration) { [weak self] in
            guard let self = self else { return }

            self.indicator.center = point
        }
    }

    private func updateShadow() {
        let wh: CGFloat = 40
        let x = abs(middleButton.frame.width / 2 - wh / 2)
        let y: CGFloat = 16 + wh / 3
        let rect = CGRect(x: x, y: y, width: wh, height: wh)

        middleButton.layer.shadowColor = Constants.Colors.primary.cgColor
        middleButton.layer.shadowPath = UIBezierPath(ovalIn: rect).cgPath
        middleButton.layer.shadowOpacity = 0.4
        middleButton.layer.shadowRadius = 8
    }

    private func updateIconPosition() {
        if #available(iOS 13, *) {
            return
        }

        for item in items ?? [] {
            // iPhone Any / iOS 11 / Portrait & Landscape
            item.landscapeImagePhoneInsets.left = -10
            item.landscapeImagePhoneInsets.right = 10

            // iPad Air / iOS 11 / Portrait & Landscape
            if traitCollection.userInterfaceIdiom == .pad {
                item.imageInsets.left = -10
                item.imageInsets.right = 10
            }
        }
    }
}

final class MainViewController: UITabBarController {

    // MARK: - UI Elements

    private let customTabBar = TabBar()

    private let middleViewController: UIViewController = {
        return UIViewController()
    }()

    // MARK: - Life Cycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        self.setValue(customTabBar, forKey: "tabBar")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        delegate = self

        setupControllers()
        setupActions()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        view.layoutIfNeeded()
        customTabBar.updateIndicator(index: selectedIndex, duration: 0)
        customTabBar.updateUI()
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

    // MARK: - Actions

    private func setupActions() {
//        customTabBar.middleButton.addTarget(self, action: #selector(tapMiddleButton(_:)), for: .touchUpInside)
    }

    @objc
    private func tapMiddleButton(_ sender: UIButton) {
        print(#function)
//        let vc = NewTaskViewController()
//        let navVC = NavigationController(rootViewController: vc)
//        navVC.modalPresentationStyle = .formSheet
//        present(navVC, animated: true)
    }
}

// MARK: - UITabBarControllerDelegate

extension MainViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard let index = viewControllers?.firstIndex(of: viewController) else {
            return false
        }

        if viewController.isEqual(middleViewController) {
            return false
        }

        customTabBar.updateIndicator(index: index)
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
