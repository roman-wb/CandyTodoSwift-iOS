//
//  EditProfileViewController.swift
//  CandyTodo
//
//  Created by roman on 17.02.2020.
//  Copyright © 2020 ROMAN DOBYNDA. All rights reserved.
//

import UIKit

final class EditProfileViewController: ViewController<EditProfileView> {

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupActions()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        customView.layoutIfNeeded()
        customView.updateUI()
        customView.setupShadow()
    }

    deinit {
       NotificationCenter.default.removeObserver(self)
    }

    // MARK: - SetupUI

    private func setupUI() {
        navigationItem.title = "EDIT PROFILE"
        customNavigationBar.barTintColor = Constants.Colors.background2

        customView.scrollView.delegate = self
    }

    // MARK: - Actions

    private func setupActions() {
        customView.saveButton.addTarget(self, action: #selector(tapSaveButton(_:)), for: .touchUpInside)

        let closeBarButtonItem = UIBarButtonItem(image: Constants.Assets.closeIcon.image,
                                                 style: .plain,
                                                 target: self,
                                                 action: #selector(tabCancelButton(_:)))
        closeBarButtonItem.tintColor = Constants.Colors.primary
        navigationItem.leftBarButtonItem = closeBarButtonItem

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardDidShow(_:)),
                                               name: UIResponder.keyboardDidShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }

    @objc
    private func tabCancelButton(_ sender: UIButton) {
        print(#function)
        dismiss(animated: true)
    }

    @objc
    private func tapSaveButton(_ sender: UIButton) {
        print(#function)
        dismiss(animated: true)
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

// MARK: - UIScrollViewDelegate

extension EditProfileViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        customView.updateUI()
    }
}

// MARK: - Preview SwiftUI

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct EditProfileViewRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let vc = EditProfileViewController()
        let navigationVC = NavigationController(rootViewController: vc)
        return navigationVC.view
    }

    func updateUIView(_ view: UIView, context: Context) {
        //
    }
}

@available(iOS 13.0.0, *)
struct EditProfileViewControllerPreview: PreviewProvider {
    static var previews: some View {
        Group {
            ForEach(PreviewDevices, id: \.self) { name in
                EditProfileViewRepresentable()
                    .previewDevice(PreviewDevice(rawValue: name))
                    .previewDisplayName(name)
                    .edgesIgnoringSafeArea(.all)
            }
        }
    }
}
#endif
