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
    }
  }
  var bottomButton: BottomButton!

  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Event Preview".localized
    bottomButton = BottomButton(addingOnView: view, title: "Я пойду".localized)
    bottomButton.addTarget(self, action: #selector(iWillGo), for: .touchUpInside)
  }

  func iWillGo() {
    // TODO: - I will go
  }

}

extension EventPreviewViewController: UITableViewDelegate, UITableViewDataSource {
  
}
