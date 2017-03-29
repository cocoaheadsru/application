//
//  UITableView+Configure.swift
//  CHMeetupApp
//
//  Created by Michael Galperin on 29.03.17.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit.UITableView
import ObjectiveC

private var associationKey = "tableView_bottom_inset"

struct TableViewConfiguration {
  var topInset: CGFloat?
  var leftInset: CGFloat?
  var bottomInset: CGFloat?
  var rightInset: CGFloat?
  var estimatedRowHeight: CGFloat?
  var rowHeight: CGFloat?
  var backgroundColor: UIColor?

  /// Tricky necessity of struct initializer.
  /// Without it when initializing you have to pass all existing parameters for correct type matching
  init(
    topInset: CGFloat? = nil,
    leftInset: CGFloat? = nil,
    bottomInset: CGFloat? = nil,
    rightInset: CGFloat? = nil,
    estimatedRowHeight: CGFloat? = nil,
    rowHeight: CGFloat? = nil,
    backgroundColor: UIColor? = nil
  ) {
    self.topInset = topInset
    self.leftInset = leftInset
    self.bottomInset = bottomInset
    self.rightInset = rightInset
    self.estimatedRowHeight = estimatedRowHeight
    self.rowHeight = rowHeight
    self.backgroundColor = backgroundColor
  }

  static var `default` = defaultConfiguration
}

private var defaultConfiguration: TableViewConfiguration {
  return TableViewConfiguration(
    topInset: 8,
    leftInset: 0,
    bottomInset: 8,
    rightInset: 0,
    estimatedRowHeight: 100,
    rowHeight: UITableViewAutomaticDimension,
    backgroundColor: .clear
  )
}

extension UITableView {

  private(set) var defaultBottomInset: CGFloat {
    get {
      return (objc_getAssociatedObject(self, &associationKey) as? CGFloat) ?? defaultConfiguration.bottomInset!
    }
    set {
      objc_setAssociatedObject(self, &associationKey, newValue, .OBJC_ASSOCIATION_RETAIN)
    }
  }

  enum ConfigurationType {
    case defaultConfiguration
    case custom(TableViewConfiguration)
  }

  func configure(with configuration: ConfigurationType) {
    switch configuration {
    case .defaultConfiguration:
      setup(configuration: defaultConfiguration)
    case let .custom(customConfig):
      setup(configuration: customConfig)
    }
  }

  private func setup(configuration: TableViewConfiguration) {
    if let topInset = configuration.topInset {
      self.contentInset.top = topInset
    }
    if let leftInset = configuration.leftInset {
      self.contentInset.left = leftInset
    }
    if let bottomInset = configuration.bottomInset {
      self.contentInset.bottom = bottomInset
      defaultBottomInset = bottomInset
    }
    if let rightInset = configuration.rightInset {
      self.contentInset.right = rightInset
    }
    if let estimated = configuration.estimatedRowHeight {
      self.estimatedRowHeight = estimated
    }
    if let rowHeight = configuration.rowHeight {
      self.rowHeight = rowHeight
    }
    if let backColor = configuration.backgroundColor {
      self.backgroundColor = backColor
    }
  }

}
