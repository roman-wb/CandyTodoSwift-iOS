//
//  LoginViewController.swift
//  CandyTodo
//
//  Created by roman on 13.02.2020.
//  Copyright © 2020 ROMAN DOBYNDA. All rights reserved.
//

import UIKit

final class LoginViewController: ViewController<LoginView> {

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

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
        navigationItem.title = "LOGIN"
        navigationController?.navigationBar.barTintColor = Constants.Colors.background1
    }

    // MARK: - Actions

    private func setupActions() {
        customView.forgotButton.addTarget(self, action: #selector(tapForgotButton(_:)), for: .touchUpInside)
        customView.showPasswordButton.addTarget(self, action: #selector(tapShowPasswordButton(_:)), for: .touchUpInside)
        customView.loginButton.addTarget(self, action: #selector(tapLoginButton(_:)), for: .touchUpInside)
        customView.registerButton.addTarget(self, action: #selector(tapRegisterButton(_:)), for: .touchUpInside)

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
    private func tapForgotButton(_ sender: UIButton) {
        print(#function)
    }

    @objc
    private func tapShowPasswordButton(_ sender: UIButton) {
        customView.passwordField.isSecureTextEntry.toggle()
        print(#function)
    }

    @objc
    private func tapLoginButton(_ sender: UIButton) {
        print(#function)
        UIWindow.transitionTo(viewController: MainViewController())
    }

    @objc
    private func tapRegisterButton(_ sender: UIButton) {
        print(#function)
        UIWindow.transitionTo(viewController: RegisterViewController.asNavigationController())
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

struct LoginViewRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        return LoginViewController().view
    }

    func updateUIView(_ view: UIView, context: Context) {
        //
    }
}

@available(iOS 13, *)
struct LoginViewControllerPreview: PreviewProvider {
    static var previews: some View {
        Group {
            ForEach(PreviewDevices, id: \.self) { name in
                LoginViewRepresentable()
                    .previewDevice(PreviewDevice(rawValue: name))
                    .previewDisplayName(name)
                    .edgesIgnoringSafeArea(.all)
            }
        }
    }
}
#endif
