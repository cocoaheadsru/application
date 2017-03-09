//
//  UITableView+Registration.swift
//  CHMeetupApp
//
//  Created by Alexander Zimin on 09/03/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit.UITableView

extension UITableView {
  func registerNib(for cellClass: UITableViewCell.Type) {
    self.register(cellClass.nib, forCellReuseIdentifier: cellClass.identifier)
  }

  func registerClass(for cellClass: UITableViewCell.Type) {
    self.register(cellClass, forCellReuseIdentifier: cellClass.identifier)
  }
}
