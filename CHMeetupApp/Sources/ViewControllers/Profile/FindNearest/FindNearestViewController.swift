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

    navigationItem.title = "Люди Рядом".localized
    displayCollection = FindNearestViewDisplayCollection()
    tableView.registerNibs(from: displayCollection)
    displayCollection.delegate = self

    controller.setOnNearestUsersUpdated { [weak self] in
      self?.tableView.reloadData()
    }
    controller.startScanning()
  }

}

// MARK: - UITableViewDataSource
extension FindNearestViewController: UITableViewDataSource {

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
