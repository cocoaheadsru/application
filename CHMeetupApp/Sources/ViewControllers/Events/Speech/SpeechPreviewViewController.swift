//
//  SpeechPreviewViewController.swift
//  CHMeetupApp
//
//  Created by Alexander Zimin on 23/02/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

class SpeechPreviewViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

  @IBOutlet weak var tableView: UITableView! {
    didSet {
      tableView.delegate = self
      tableView.dataSource = self
      tableView.registerNib(for: SpeakerTableViewCell.self)
      tableView.backgroundColor = UIColor(red: 0.922, green: 0.929, blue: 0.929, alpha: 1.00)
    }
  }
  override func viewDidLoad() {
    super.viewDidLoad()

    title = "Speech".localized
    view.backgroundColor = UIColor(red: 0.922, green: 0.929, blue: 0.929, alpha: 1.00)
  }

  // MARK: - UITableViewDelegate
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 260
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return tableView.dequeueReusableCell(for: indexPath) as SpeakerTableViewCell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print("debug tap")
  }
}
