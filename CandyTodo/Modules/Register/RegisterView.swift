//
//  RegisterView.swift
//  CandyTodo
//
//  Created by roman on 13.02.2020.
//  Copyright © 2020 ROMAN DOBYNDA. All rights reserved.
//

import UIKit

final class RegisterView: UIView {

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
            .font: Constants.Fonts.avenirMedium.size(12),
        ]
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.leftViewMode = .always
        textField.isSecureTextEntry = true
        return textField
    }()

    private var confirmPasswordLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "Confirm Password", attributes: [
            .foregroundColor: Constants.Colors.primary,
            .font: Constants.Fonts.avenirBook.size(12),
        ])
        return label
    }()

    let confirmPasswordField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.layer.borderWidth = 1
        textField.layer.borderColor = Constants.Colors.background2.cgColor
        textField.layer.cornerRadius = 8
        textField.defaultTextAttributes = [
            .foregroundColor: Constants.Colors.primary,
            .font: Constants.Fonts.avenirMedium.size(12),
        ]
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.leftViewMode = .always
        textField.isSecureTextEntry = true
        return textField
    }()

    let registerButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Constants.Colors.primary
        button.layer.cornerRadius = 8

        let title = "Register"
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

    let loginButton: UIButton = {
        let button = UIButton()
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0.01, bottom: 0.01, right: 0)

        let title = "Have account? Log In"
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

    let termsButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0.01, bottom: 0.01, right: 0)

        let title = "By registering, you automatically accept the Terms & Policies of candy app."
        let font = Constants.Fonts.avenirBook.size(12)
        let linkFont = Constants.Fonts.avenirMedium.size(12)

        let normalTitle = NSMutableAttributedString(string: title, attributes: [
            .foregroundColor: Constants.Colors.primary,
            .font: font,
        ])
        let range = normalTitle.mutableString.range(of: "Terms & Policies")
        normalTitle.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range)
        normalTitle.addAttribute(.font, value: linkFont, range: range)
        button.setAttributedTitle(normalTitle, for: .normal)

        let highlightedTitle = NSMutableAttributedString(string: title, attributes: [
            .foregroundColor: Constants.Colors.primary,
            .font: font,
        ])
        highlightedTitle.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range)
        highlightedTitle.addAttribute(.font, value: linkFont, range: range)
        highlightedTitle.addAttribute(.foregroundColor, value: Constants.Colors.secondary, range: range)
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

extension RegisterView {

    private func setupUI() {
        backgroundColor = Constants.Colors.background1

        addSubview(scrollView)
            scrollView.addSubview(contentView)
                contentView.addSubview(stackView)
                contentView.addSubview(termsButton)
                contentView.addSubview(loginButton)

        stackView.addArrangedSubview(emailLabel)
        stackView.setCustomSpacing(8, after: emailLabel)
        stackView.addArrangedSubview(emailField)
        stackView.setCustomSpacing(16, after: emailField)
        stackView.addArrangedSubview(passwordLabel)
        stackView.setCustomSpacing(8, after: passwordLabel)
        stackView.addArrangedSubview(passwordField)
        stackView.setCustomSpacing(16, after: passwordField)
        stackView.addArrangedSubview(confirmPasswordLabel)
        stackView.setCustomSpacing(8, after: confirmPasswordLabel)
        stackView.addArrangedSubview(confirmPasswordField)
        stackView.setCustomSpacing(40, after: confirmPasswordField)
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
        }

        emailField.snp.makeConstraints { (make) in
            make.height.equalTo(51)
        }

        passwordField.snp.makeConstraints { (make) in
            make.height.equalTo(51)
        }

        confirmPasswordField.snp.makeConstraints { (make) in
            make.height.equalTo(51)
        }

        registerButton.snp.makeConstraints { (make) in
            make.height.equalTo(51)
        }

        termsButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(stackView.snp.bottom).offset(40)
            make.width.equalTo(180)
            make.height.equalTo(50)
        }

        loginButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(termsButton.snp.bottom).offset(40)
            make.bottom.equalTo(-20)
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
