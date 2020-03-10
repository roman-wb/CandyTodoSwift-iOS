//
//  NewTaskView.swift
//  CandyTodo
//
//  Created by roman on 20.02.2020.
//  Copyright © 2020 ROMAN DOBYNDA. All rights reserved.
//

import UIKit
import SnapKit

final class NewTaskView: UIView {

    // MARK: - UI Elements

    var scrollView: ScrollView = {
        let scrollView = ScrollView()
        return scrollView
    }()

    private var contentView: UIView = {
        let view = UIView()
        return view
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()

    private var headerViewConstraint: Constraint!

    private let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(patternImage: Constants.Assets.headerBackground.image)
        return view
    }()

    let nameTextView: UITextView = {
        let textView = TextView()
        textView.contentInset.left = -5
        textView.backgroundColor = .clear
        let font = Constants.Fonts.avenirBlack.size(24)
        textView.typingAttributes = [
            .foregroundColor: Constants.Colors.primary,
            .font: font,
        ]
        textView.placeholderLabel.attributedText = NSAttributedString(string: "Write here....", attributes: [
            .foregroundColor: Constants.Colors.secondary,
            .font: font,
        ])
        return textView
    }()

    private let completeLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "Complete by", attributes: [
            .foregroundColor: Constants.Colors.primary,
            .font: Constants.Fonts.avenirBook.size(12),
        ])
        return label
    }()

    let completeTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.layer.borderWidth = 1
        textField.layer.borderColor = Constants.Colors.borderField.cgColor
        textField.layer.cornerRadius = 8
        let font = Constants.Fonts.avenirMedium.size(12)
        textField.defaultTextAttributes = [
            .foregroundColor: Constants.Colors.primary,
            .font: font,
        ]
        textField.attributedPlaceholder = NSAttributedString(string: "Select a date", attributes: [
            .foregroundColor: Constants.Colors.secondary,
            .font: font,
        ])
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.leftViewMode = .always
        return textField
    }()

    private let priorityLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "Priority", attributes: [
            .foregroundColor: Constants.Colors.primary,
            .font: Constants.Fonts.avenirBook.size(12),
        ])
        return label
    }()

    let priorityTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.layer.borderWidth = 1
        textField.layer.borderColor = Constants.Colors.borderField.cgColor
        textField.layer.cornerRadius = 8
        let font = Constants.Fonts.avenirMedium.size(12)
        textField.defaultTextAttributes = [
            .foregroundColor: Constants.Colors.primary,
            .font: font,
        ]
        textField.attributedPlaceholder = NSAttributedString(string: "", attributes: [
            .foregroundColor: Constants.Colors.secondary,
            .font: font,
        ])
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.leftViewMode = .always
        return textField
    }()

    private let moreLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "More Options", attributes: [
            .foregroundColor: Constants.Colors.secondary,
            .font: Constants.Fonts.avenirBook.size(12),
        ])
        return label
    }()

    private let alarmLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "Save as alarm", attributes: [
            .foregroundColor: Constants.Colors.primary,
            .font: Constants.Fonts.avenirBook.size(12),
        ])
        return label
    }()

    let alarmSwitch: UISwitch = {
        let button = UISwitch()
        button.backgroundColor = .white
        button.tintColor = .white
        button.onTintColor = Constants.Colors.borderSwitch
        if #available(iOS 13, *) {
            if let subview = button.subviews.first?.subviews.first {
                subview.backgroundColor = .white
            }
        }
        button.layer.masksToBounds = true
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = 16.0
        button.layer.borderColor = Constants.Colors.borderSwitch.cgColor
        return button
    }()

    private let notifyLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "Show as notification", attributes: [
            .foregroundColor: Constants.Colors.primary,
            .font: Constants.Fonts.avenirBook.size(12),
        ])
        return label
    }()

    let notifySwitch: UISwitch = {
        let button = UISwitch()
        button.isOn = true
        button.backgroundColor = .white
        button.tintColor = .white
        button.onTintColor = Constants.Colors.borderSwitch
        if #available(iOS 13, *) {
            if let subview = button.subviews.first?.subviews.first {
                subview.backgroundColor = .white
            }
        }
        button.layer.masksToBounds = true
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = 16.0
        button.layer.borderColor = Constants.Colors.borderSwitch.cgColor
        return button
    }()

    private var saveButtonTopOffset: CGFloat = 16

    private var saveButtonBottomOffset: CGFloat {
        if safeAreaInsets.bottom > 0 {
            return safeAreaInsets.bottom
        }
        return saveButtonTopOffset
    }

    private var saveButtonConstraint: Constraint!

    let saveButton: UIButton = {
        let button = UIButton()
        button.setImage(Constants.Assets.saveIcon.image, for: .normal)
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

    // MARK: - SetupUI

    func setupShadow() {
        let wh: CGFloat = 40
        let x = abs(saveButton.frame.width / 2 - wh / 2)
        let y: CGFloat = 16 + wh / 3
        let rect = CGRect(x: x, y: y, width: wh, height: wh)

        saveButton.layer.shadowColor = Constants.Colors.primary.cgColor
        saveButton.layer.shadowPath = UIBezierPath(ovalIn: rect).cgPath
        saveButton.layer.shadowOpacity = 0.4
        saveButton.layer.shadowRadius = 8
    }

    private func setupUI() {
        backgroundColor = .white

        let alarmStackView = UIStackView(arrangedSubviews: [alarmLabel, alarmSwitch])
        let notifyStackView = UIStackView(arrangedSubviews: [notifyLabel, notifySwitch])

        addSubview(scrollView)
            scrollView.addSubview(contentView)
                contentView.addSubview(headerView)
                    headerView.addSubview(nameTextView)
                contentView.addSubview(stackView)
                    stackView.addArrangedSubview(completeLabel)
                    stackView.setCustomSpacing(8, after: completeLabel)
                    stackView.addArrangedSubview(completeTextField)
                    stackView.setCustomSpacing(16, after: completeTextField)
                    stackView.addArrangedSubview(priorityLabel)
                    stackView.setCustomSpacing(8, after: priorityLabel)
                    stackView.addArrangedSubview(priorityTextField)
                    stackView.setCustomSpacing(32, after: priorityTextField)
                    stackView.addArrangedSubview(moreLabel)
                    stackView.setCustomSpacing(29, after: moreLabel)
                    stackView.addArrangedSubview(alarmStackView)
                    stackView.setCustomSpacing(27, after: alarmStackView)
                    stackView.addArrangedSubview(notifyStackView)

        addSubview(saveButton)
    }

    private func setupConstraints() {
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

        contentView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.width.equalTo(snp.width)
        }

        headerView.snp.makeConstraints { (make) in
            headerViewConstraint = make.top.equalToSuperview().constraint
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(112)
        }

        nameTextView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.leading.equalTo(safeAreaLayoutGuide).offset(32)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-32)
            make.bottom.equalToSuperview().offset(-10)
        }

        stackView.snp.makeConstraints { (make) in
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.top.equalTo(112 + 16)
            make.leading.equalTo(safeAreaLayoutGuide).offset(32)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-32)
            make.bottom.equalToSuperview()
        }

        completeTextField.snp.makeConstraints { (make) in
            make.height.equalTo(51)
        }

        priorityTextField.snp.makeConstraints { (make) in
            make.height.equalTo(51)
        }

        saveButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(safeAreaLayoutGuide)
            saveButtonConstraint = make.bottom.equalTo(safeAreaLayoutGuide).constraint
        }
    }

    // MARK: - UpdateUI

    func updateUI() {
        updateHeader()
        updateInsets()
        updateButton()
    }

    private func updateHeader() {
        if scrollView.topOffset < 0 {
            headerViewConstraint.update(offset: scrollView.topOffset)
        } else {
            headerViewConstraint.update(offset: 0)
        }
    }

    private func updateInsets() {
        var bottomInset = scrollView.keyboardRect.height + saveButton.frame.height
        bottomInset += saveButtonTopOffset

        if scrollView.keyboardRect.height > 0 {
            bottomInset += saveButtonTopOffset
        } else {
            bottomInset += saveButtonBottomOffset
        }

        scrollView.contentInset.bottom = bottomInset - safeAreaInsets.bottom
        scrollView.fallbackVerticalScrollIndicatorInsets.bottom = scrollView.keyboardRect.height - safeAreaInsets.bottom
    }

    private func updateButton() {
        // Nullable bottom safe area
        var offset: CGFloat = safeAreaInsets.bottom

        if scrollView.isOverflowHeight {
            offset -= scrollView.keyboardRect.height
            if scrollView.keyboardRect.height > 0 {
                offset -= saveButtonTopOffset
            } else {
                offset -= saveButtonBottomOffset
            }
            offset += scrollView.bottomOffset + safeAreaInsets.bottom
//            print("Offset", offset)
        } else if scrollView.keyboardRect.height > 0 {
            offset = -scrollView.keyboardRect.height
//            print("Keyboard", offset)
        } else {
            offset -= saveButtonBottomOffset
//            print("Static", offset)
        }

        saveButtonConstraint.update(offset: offset)
    }
}
