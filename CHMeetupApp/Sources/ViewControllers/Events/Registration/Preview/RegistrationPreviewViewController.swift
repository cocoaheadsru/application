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
  var dataCollection: FormData?

  override func viewDidLoad() {
    super.viewDidLoad()
    keyboardDelegate = self
    
    bottomButton = BottomButton(addingOnView: view, title: "Регистрация".localized)
    bottomButton.addTarget(self, action: #selector(registrate), for: .touchUpInside)

    // FIXME: - Get test data from server
    RegistrationController.loadRegFromServer(with: 1, complitionBlock: { (form: EventRegFormPlainObject) in
      DispatchQueue.main.async {
        self.dataCollection = FormData(with: form)
        self.tableView.reloadData()
      }
    })

  }

  func registrate() {
    print("registrate pressed")
  }
  
}

// MARK: - UITableViewDataSource
extension RegistrationPreviewViewController: UITableViewDataSource {

  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return dataCollection?.sections[section].name ?? ""
  }

  func numberOfSections(in tableView: UITableView) -> Int {
    return dataCollection?.sections.count ?? 0
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dataCollection?.sections[section].fieldAnswers.count ?? 0
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    // FIXME: - Just for test
    let cell = UITableViewCell(style: .default, reuseIdentifier: "UITableViewCell")
    cell.textLabel?.text = dataCollection?.sections[indexPath.section].fieldAnswers[indexPath.row].value
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
