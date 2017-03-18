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
      tableView.delegate            = self
      tableView.dataSource          = self
      tableView.backgroundColor     = UIColor.clear
      tableView.rowHeight           = UITableViewAutomaticDimension
      tableView.estimatedRowHeight  = 260
      tableView.registerNib(for: SpeachPreviewTableViewCell.self)
    }
  }
  override func viewDidLoad() {
    super.viewDidLoad()

    title = "Speech".localized
    view.backgroundColor = UIColor(.lightGray)
  }

  // MARK: - UITableViewDelegate

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let model = SpeachPreviewTableViewCellModel(firstName: "Александр",
                                                lastName: "Зимин",
                                                userPhoto: Data(),
                                                speakerDescription: "Cоздатель печально известного проекта Motivate Me",
                                                topic: "Как вложить в приложение минимум функций",
                                                speachDescription: "Опыт работы с кофаундерами Активитис и прочие анальные боли")
    let cell = tableView.dequeueReusableCell(for: indexPath, with: model) as? SpeachPreviewTableViewCell
    return cell!
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print("debug tap")
  }
}
