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
//      tableView.allowsMultipleSelection = true
      let configuration = TableViewConfiguration(
        bottomInset: 8 + BottomButton.constantHeight,
        estimatedRowHeight: 44)
      tableView.configure(with: .custom(configuration))
      tableView.scrollIndicatorInsets = UIEdgeInsets(top: 0,
                                                     left: 0,
                                                     bottom: BottomButton.constantHeight,
                                                     right: 0)
      tableView.registerHeaderNib(for: RegistrationConfirmTableViewHeader.self)
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

    title = "Подтверждение".localized
    
    bottomButton = BottomButton(addingOnView: view, title: "Закрыть".localized)
    
    displayCollection = RegistrationConfirmDisplayCollection()
    tableView.registerNibs(from: displayCollection)

  }
  
  func closeButtonAction() {
//    Storyboards.Main.
  }
  
}
