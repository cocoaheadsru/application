//
//  RegistrationPreviewViewController.swift
//  CHMeetupApp
//
//  Created by Alexander Zimin on 23/02/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

class RegistrationPreviewViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView! {
    didSet {
      tableView.dataSource = self
    }
  }

  var bottomButton: BottomButton!
  var displayCollection: FormDisplayCollection?

  override func viewDidLoad() {
    super.viewDidLoad()
    keyboardDelegate = self

    bottomButton = BottomButton(addingOnView: view, title: "Регистрация".localized)
    bottomButton.addTarget(self, action: #selector(registrate), for: .touchUpInside)

    // FIXME: - Get test data from server
    RegistrationController.loadRegFromServer(with: 1,
                                             complition: { [weak self] (displayCollection: FormDisplayCollection) in
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

    var tableViewContnetInsets = tableView.contentInset
    var indicatorContentInsets = tableView.scrollIndicatorInsets

    switch state {
    case .frameChanged, .opened:
      tableViewContnetInsets.bottom = info.endFrame.height
      indicatorContentInsets.bottom = info.endFrame.height
    case .hidden:
      tableViewContnetInsets.bottom = 0
      indicatorContentInsets.bottom = 0
    }

    tableView.contentInset = tableViewContnetInsets
    tableView.scrollIndicatorInsets = indicatorContentInsets
  }
}
