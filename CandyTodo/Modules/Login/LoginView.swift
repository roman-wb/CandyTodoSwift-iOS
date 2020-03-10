//
//  LoginView.swift
//  CandyTodo
//
//  Created by roman on 13.02.2020.
//  Copyright © 2020 ROMAN DOBYNDA. All rights reserved.
//

import UIKit

final class LoginView: UIView {

    // MARK: - UI elements

    let scrollView: ScrollView = {
        let scrollView = ScrollView()
        return scrollView
    }()

    private let contentView: UIView = {
        return UIView()
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()

    private let emailLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "Email", attributes: [
            .foregroundColor: Constants.Colors.primary,
            .font: Constants.Fonts.avenirBook.size(12),
        ])
        return label
    }()

    let emailField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.layer.borderWidth = 1
        textField.layer.borderColor = Constants.Colors.background2.cgColor
        textField.layer.cornerRadius = 8
        textField.defaultTextAttributes = [
            .foregroundColor: Constants.Colors.primary,
            .font: Constants.Fonts.avenirBook.size(12),
        ]
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.leftViewMode = .always
        return textField
    }()

    private var passwordLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "Password", attributes: [
            .foregroundColor: Constants.Colors.primary,
            .font: Constants.Fonts.avenirBook.size(12),
        ])
        return label
    }()

    let passwordField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.layer.borderWidth = 1
        textField.layer.borderColor = Constants.Colors.background2.cgColor
        textField.layer.cornerRadius = 8
        textField.defaultTextAttributes = [
            .foregroundColor: Constants.Colors.primary,
            .font: Constants.Fonts.avenirBook.size(12),
        ]
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.leftViewMode = .always
        textField.isSecureTextEntry = true
        return textField
    }()

    let showPasswordButton: UIButton = {
        let button = UIButton()
        button.setImage(Constants.Assets.eyeIcon.image, for: .normal)
        button.sizeToFit()
        return button
    }()

    let forgotButton: UIButton = {
        let button = UIButton()
        button.layer.opacity = 0.5
        button.contentEdgeInsets = UIEdgeInsets(top: 0.01, left: 0, bottom: 0.01, right: 0)

        let title = "Forgot?"
        let font = Constants.Fonts.avenirBook.size(12)

        let normalTitle = NSAttributedString(string: title, attributes: [
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .foregroundColor: Constants.Colors.primary,
            .font: font,
        ])
        button.setAttributedTitle(normalTitle, for: .normal)

        let highlightedTitle = NSAttributedString(string: title, attributes: [
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .foregroundColor: Constants.Colors.secondary,
            .font: font,
        ])
        button.setAttributedTitle(highlightedTitle, for: .highlighted)

        return button
    }()

    let loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Constants.Colors.primary
        button.layer.cornerRadius = 8

        let title = "Login"
        let font = Constants.Fonts.avenirHeavy.size(14)

        let normalTitle = NSAttributedString(string: title, attributes: [
            .foregroundColor: UIColor.white,
            .font: font,
        ])
        button.setAttributedTitle(normalTitle, for: .normal)

        let highlightedTitle = NSAttributedString(string: title, attributes: [
            .foregroundColor: UIColor.gray,
            .font: font,
        ])
        button.setAttributedTitle(highlightedTitle, for: .highlighted)

        return button
    }()

    let registerButton: UIButton = {
        let button = UIButton()
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0.01, bottom: 0.01, right: 0)

        let title = "New User? Register Here"
        let font = Constants.Fonts.avenirHeavy.size(14)

        let normalTitle = NSAttributedString(string: title, attributes: [
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .foregroundColor: Constants.Colors.primary,
            .font: font,
        ])
        button.setAttributedTitle(normalTitle, for: .normal)

        let highlightedTitle = NSAttributedString(string: title, attributes: [
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .foregroundColor: Constants.Colors.secondary,
            .font: font,
        ])
        button.setAttributedTitle(highlightedTitle, for: .highlighted)

        return button
    }()

    // MARK: - Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - SetupUI

extension LoginView {

    private func setupUI() {
        backgroundColor = Constants.Colors.background1

        let passwordStackView = UIStackView()
        passwordStackView.distribution = .equalSpacing
        passwordStackView.addArrangedSubview(passwordLabel)
        passwordStackView.addArrangedSubview(forgotButton)

        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 28, height: 20))
        leftView.addSubview(showPasswordButton)
        passwordField.rightView = leftView
        passwordField.rightViewMode = .always

        addSubview(scrollView)
            scrollView.addSubview(contentView)
                contentView.addSubview(stackView)

        stackView.addArrangedSubview(emailLabel)
        stackView.setCustomSpacing(8, after: emailLabel)
        stackView.addArrangedSubview(emailField)
        stackView.setCustomSpacing(16, after: emailField)
        stackView.addArrangedSubview(passwordStackView)
        stackView.setCustomSpacing(8, after: passwordStackView)
        stackView.addArrangedSubview(passwordField)
        stackView.setCustomSpacing(40, after: passwordField)
        stackView.addArrangedSubview(loginButton)
        stackView.setCustomSpacing(40, after: loginButton)
        stackView.addArrangedSubview(registerButton)
    }

    private func setupConstraints() {
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

        contentView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }

        stackView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalTo(312).priority(.medium)
            make.top.equalTo(20)
            make.leading.greaterThanOrEqualTo(20)
            make.trailing.lessThanOrEqualTo(-20)
            make.bottom.equalTo(-20)
        }

        emailField.snp.makeConstraints { (make) in
            make.height.equalTo(51)
        }

        passwordField.snp.makeConstraints { (make) in
            make.height.equalTo(51)
        }

        loginButton.snp.makeConstraints { (make) in
            make.height.equalTo(51)
        }
    }

    func updateUI() {
        var scrollViewInsets = UIEdgeInsets.zero
        let scrollViewBounds = scrollView.bounds
        let containerViewBounds = contentView.bounds

        let offset = (scrollViewBounds.height - scrollView.keyboardRect.height ) / 2
                        - containerViewBounds.height / 2 - safeAreaInsets.bottom / 2

        if offset > 0 {
            scrollViewInsets.top = offset
            scrollViewInsets.bottom = offset
            scrollView.fallbackVerticalScrollIndicatorInsets.bottom = 0
        } else {
            scrollViewInsets.bottom = scrollView.keyboardRect.height - safeAreaInsets.bottom
            scrollView.fallbackVerticalScrollIndicatorInsets.bottom = scrollView.keyboardRect.height - safeAreaInsets.bottom
        }

        scrollView.contentInset = scrollViewInsets
    }
}
