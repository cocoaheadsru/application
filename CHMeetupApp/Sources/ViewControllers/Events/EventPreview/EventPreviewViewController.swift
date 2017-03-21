//
//  EventPreviewViewController.swift
//  CHMeetupApp
//
//  Created by Alexander Zimin on 23/02/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

class EventPreviewViewController: UIViewController {
  @IBOutlet var tableView: UITableView! {
    didSet {
      tableView.estimatedRowHeight = 100
      tableView.rowHeight = UITableViewAutomaticDimension
      tableView.backgroundColor = UIColor.clear
      tableView.registerNib(for: ProfileNameCell.self)
    }
  }
  var bottomButton: BottomButton!
  var displayCollection: EventPreviewDisplayCollection!

  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Event Preview".localized
    bottomButton = BottomButton(addingOnView: view, title: "Я пойду".localized)
    bottomButton.addTarget(self, action: #selector(iWillGo), for: .touchUpInside)
    displayCollection = EventPreviewDisplayCollection()
  }

  func iWillGo() {
    // TODO: - I will go
  }

}

extension EventPreviewViewController: UITableViewDelegate, UITableViewDataSource {

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

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return displayCollection.height(for: indexPath)
  }
}
