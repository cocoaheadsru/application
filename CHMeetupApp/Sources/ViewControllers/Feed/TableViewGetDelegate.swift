//
//  TableViewGetDelegate.swift
//  CHMeetupApp
//
//  Created by Kirill Averyanov on 16/04/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

protocol TableViewGetDelegate: class {
  func getIndexPath(from cell: UITableViewCell) -> IndexPath?
}
