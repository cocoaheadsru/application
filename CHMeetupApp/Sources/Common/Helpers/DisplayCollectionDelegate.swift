//
//  DisplayCollectionDelegate.swift
//  CHMeetupApp
//
//  Created by Sam Mejlumyan on 11/04/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

protocol DisplayCollectionDelegate: class {
  func updateUI()
  func presentModalViewController(_ viewController: UIViewController)
  func pushViewController(_ viewController: UIViewController)
}

extension UIViewController: DisplayCollectionDelegate {
  func presentModalViewController(_ viewController: UIViewController) {
    present(viewController, animated: true, completion: nil)
  }

  func pushViewController(_ viewController: UIViewController) {
    navigationController?.pushViewController(viewController, animated: true)
  }

  func updateUI() {
    if let tableView = self.value(forKey: "tableView") as? UITableView {
      tableView.reloadData()
    }
  }
}
