//
//  CreatorsViewController.swift
//  CHMeetupApp
//
//  Created by Sam Mejlumyan on 16/04/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

class CreatorsViewController: UIViewController, DisplayCollectionWithTableViewDelegate {
  @IBOutlet var tableView: UITableView! {
    didSet {
      tableView.configure(with: .defaultConfiguration)
    }
  }

  fileprivate var displayCollection: CreatorsViewDisplayCollection!

  override func viewDidLoad() {
    super.viewDidLoad()

    navigationItem.title = "Создатели".localized
    displayCollection = CreatorsViewDisplayCollection()
    tableView.registerNibs(from: displayCollection)
    fetchCreators()
  }
}

// MARK: - UITableViewDataSource

extension CreatorsViewController: UITableViewDataSource {
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

extension CreatorsViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    displayCollection.didSelect(indexPath: indexPath)
  }
}

fileprivate extension CreatorsViewController {
  func fetchCreators() {
    displayCollection.creators.isLoading = true
    CreatorsFetching.fetchElements(request: UserPlainObject.Requests.listOfCreators, completion: { [weak self] in
      self?.displayCollection.creators.isLoading = false
      self?.tableView.reloadData()
    })
  }
}
