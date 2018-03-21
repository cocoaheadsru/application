//
//  FindNearestViewController.swift
//  CHMeetupApp
//
//  Created by Chingis Gomboev on 12/03/2018.
//  Copyright © 2018 CocoaHeads Community. All rights reserved.
//

import UIKit

class FindNearestViewController: UIViewController, DisplayCollectionWithTableViewDelegate {

  // MARK: - Dependencies

  private let controller = FindNearestController()

  // MARK: - Properties

  @IBOutlet var tableView: UITableView! {
    didSet {
      let configuration = TableViewConfiguration(
        topInset: 8,
        bottomInset: 8,
        bottomIndicatorInset: 0,
        estimatedRowHeight: 100)
      tableView.configure(with: .custom(configuration))
    }
  }

  fileprivate var displayCollection: FindNearestViewDisplayCollection!

  // MARK: Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()

    navigationItem.title = "Люди Вокруг".localized
    displayCollection = FindNearestViewDisplayCollection()
    tableView.registerNibs(from: displayCollection)
    displayCollection.delegate = self
    displayCollection.updateActionCellsSection(on: self, with: tableView)

    controller.setOnNearestUsersUpdated { [weak self] in
      guard let `self` = self else {return}
      self.tableView.reloadSections(self.displayCollection.nearestUsersSection, with: .none)
    }
    controller.startScanning()
  }

  override func updateUI() {
    displayCollection.updateActionCellsSection(on: self, with: tableView)
    super.updateUI()
  }
}

// MARK: - UITableViewDataSource
extension FindNearestViewController: UITableViewDataSource {
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
}

// MARK: - UITableViewDelegate
extension FindNearestViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    displayCollection.didSelect(indexPath: indexPath)
  }
}
