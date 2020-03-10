//
//  RegisterViewController.swift
//  CandyTodo
//
//  Created by roman on 13.02.2020.
//  Copyright © 2020 ROMAN DOBYNDA. All rights reserved.
//

import UIKit

final class RegisterViewController: ViewController<RegisterView> {

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)

        setupUI()
        setupActions()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        view.layoutIfNeeded()
        customView.updateUI()
    }

    static func asNavigationController() -> NavigationController {
        let vc = Self()
        let navVC = NavigationController(rootViewController: vc)
        return navVC
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: - SetupUI

    private func setupUI() {
        navigationItem.title = "REGISTER"
        navigationController?.navigationBar.barTintColor = Constants.Colors.background1
    }

    // MARK: - Actions

    private func setupActions() {
        customView.registerButton.addTarget(self, action: #selector(tapRegisterButton(_:)), for: .touchUpInside)
        customView.termsButton.addTarget(self, action: #selector(tapTermsButton(_:)), for: .touchUpInside)
        customView.loginButton.addTarget(self, action: #selector(tapLoginButton(_:)), for: .touchUpInside)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardDidShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }

    @objc
    private func tapRegisterButton(_ sender: UIButton) {
        print(#function)
        UIWindow.transitionTo(viewController: MainViewController())
    }

    @objc
    private func tapTermsButton(_ sender: UIButton) {
        print(#function)
    }

    @objc
    private func tapLoginButton(_ sender: UIButton) {
        print(#function)
        UIWindow.transitionTo(viewController: LoginViewController.asNavigationController())
    }

    @objc
    private func keyboardDidShow(_ notification: Notification) {
        customView.updateUI()
    }

    @objc
    private func keyboardWillHide(_ notification: Notification) {
        customView.updateUI()
    }
}

// MARK: - Preview SwiftUI

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct RegisterViewRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        return RegisterViewController().view
    }

    func updateUIView(_ view: UIView, context: Context) {
        //
    }
}

@available(iOS 13.0.0, *)
struct RegisterViewControllerPreview: PreviewProvider {
    static var previews: some View {
        Group {
            ForEach(PreviewDevices, id: \.self) { name in
                RegisterViewRepresentable()
                    .previewDevice(PreviewDevice(rawValue: name))
                    .previewDisplayName(name)
                    .edgesIgnoringSafeArea(.all)
            }
        }
    }
}
#endif
