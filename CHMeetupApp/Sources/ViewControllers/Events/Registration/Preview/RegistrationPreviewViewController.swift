//
//  RegistrationPreviewViewController.swift
//  CHMeetupApp
//
//  Created by Alexander Zimin on 23/02/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

private let bottomMargin: CGFloat = 8

class RegistrationPreviewViewController: UIViewController {

  @IBOutlet fileprivate var tableView: UITableView! {
    didSet {
      tableView.dataSource = self
      tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: bottomMargin, right: 0)
    }
  }

  fileprivate var bottomButton: BottomButton!
  fileprivate var displayCollection: FormDisplayCollection?

  override func viewDidLoad() {
    super.viewDidLoad()
    keyboardDelegate = self

    bottomButton = BottomButton(addingOnView: view, title: "Регистрация".localized)
    bottomButton.addTarget(self, action: #selector(registrate), for: .touchUpInside)

    // FIXME: - Get test data from server
    RegistrationController.loadRegFromServer(
      with: 1,
      completion: { [weak self] (displayCollection: FormDisplayCollection) in
        self?.displayCollection = displayCollection
        self?.tableView.reloadData()
    })

  }

  func registrate() {
    let confirmViewController = Storyboards.EventPreview.instantiateRegistrationConfirmViewController()
    navigationController?.pushViewController(confirmViewController, animated: true)
  }

}

// MARK: - UITableViewDataSource
extension RegistrationPreviewViewController: UITableViewDataSource {

  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return displayCollection?.headerTitle(for: section) ?? ""
  }

  func numberOfSections(in tableView: UITableView) -> Int {
    return displayCollection?.numberOfSections ?? 0
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return displayCollection?.numberOfRows(in: section) ?? 0
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let model = displayCollection?.model(for: indexPath)
    let cell = tableView.dequeueReusableCell(for: indexPath, with: model!)
    return cell
  }

}

// MARK: - KeyboardHandlerDelegate
extension RegistrationPreviewViewController: KeyboardHandlerDelegate {

  func keyboardStateChanged(input: UIView?, state: KeyboardState, info: KeyboardInfo) {

    var buttonInsets: CGFloat = 0

    switch state {
    case .frameChanged, .opened:
      let tableViewBottomContentInsets = info.endFrame.height + bottomMargin + bottomButton.frame.height
      tableView.contentInset.bottom = tableViewBottomContentInsets
      tableView.scrollIndicatorInsets.bottom = info.endFrame.height + bottomButton.frame.height
      buttonInsets = info.endFrame.height
    case .hidden:
      tableView.contentInset.bottom = 0
      tableView.scrollIndicatorInsets.bottom = 0
      buttonInsets = 0
    }

    info.animate ({ [weak self] in
      self?.bottomButton.bottomInsetsConstant = buttonInsets
      self?.view.layoutIfNeeded()
    })
  }
}
