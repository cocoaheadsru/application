//
//  RegistrationConfirmViewController.swift
//  CHMeetupApp
//
//  Created by Alexander Zimin on 23/02/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

class RegistrationConfirmViewController: UIViewController {

  @IBOutlet var tableView: UITableView! {
    didSet {
      let configuration = TableViewConfiguration(
        bottomInset: 8 + BottomButton.constantHeight,
        bottomIndicatorInset: BottomButton.constantHeight,
        estimatedRowHeight: 100
      )
      tableView.configure(with: .custom(configuration))
    }
  }

  fileprivate var bottomButton: BottomButton! {
    didSet {
      bottomButton.addTarget(self, action: #selector(closeButtonAction), for: .touchUpInside)
    }
  }

  fileprivate var displayCollection: RegistrationConfirmDisplayCollection!

  override func viewDidLoad() {
    super.viewDidLoad()

    navigationController?.setNavigationBarHidden(true, animated: true)
    bottomButton = BottomButton(addingOnView: view, title: "Закрыть".localized)
    displayCollection = RegistrationConfirmDisplayCollection()
    displayCollection.configureActionCellsSection(on: self, with: tableView)
    tableView.registerNibs(from: displayCollection)
  }

  func closeButtonAction() {
    // Setup default (previus) visibility for navigation bar
    navigationController?.setNavigationBarHidden(false, animated: false)
    // Go to main screen
    navigationController?.popToRootViewController(animated: true)
  }
}

// MARK: - UITableViewDataSource
extension RegistrationConfirmViewController: UITableViewDataSource, UITableViewDelegate {
  func numberOfSections(in tableView: UITableView) -> Int {
    return displayCollection.numberOfSections
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return displayCollection.numberOfRows(in: section)
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let model = displayCollection.model(for: indexPath)
    let cell = tableView.dequeueReusableCell(for: indexPath, with: model)
    return cell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    displayCollection.didSelect(indexPath: indexPath)
  }
}
