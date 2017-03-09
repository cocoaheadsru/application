//
//  PastEventsViewController.swift
//  CHMeetupApp
//
//  Created by Alexander Zimin on 22/02/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

class PastEventsViewController: UIViewController {
  @IBOutlet fileprivate var tableView: UITableView! {
    didSet {
      tableView.registerNib(for: PastEventsTableViewCell.self)
      tableView.estimatedRowHeight = 100
      tableView.rowHeight = UITableViewAutomaticDimension
    }
  }
  fileprivate var dataCollection: PastEventsDisplayCollection!

  override func viewDidLoad() {
    dataCollection = PastEventsDisplayCollection()
    super.viewDidLoad()
    fetchEvents()
  }

  override func customTabBarItemContentView() -> CustomTabBarItemView {
    return TabBarItemView.create(with: .past)
  }
}

extension PastEventsViewController: UITableViewDataSource, UITableViewDelegate {

  func numberOfSections(in tableView: UITableView) -> Int {
    return dataCollection.numberOfSections
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dataCollection.numberOfRows(in: section)
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let model = dataCollection.modelForIndexPath(indexPath: indexPath)
    let cell = tableView.dequeueReusableCell(for: indexPath, with: model)
    return cell
  }

  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    let title = dataCollection.headerTitle(for: section)
    return title
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    showEvent(at: indexPath)
  }
}

fileprivate extension PastEventsViewController {

  func fetchEvents() {
    //FIXME: Replace with real data
    let numberOfDemoEvents = 10
    for eventIndex in 1...numberOfDemoEvents {
      //Create past event
      let oneDayTimeInterval = 3600 * 24
      let eventTime = Date().addingTimeInterval(-TimeInterval(oneDayTimeInterval * eventIndex))
      let eventDuration: TimeInterval = 3600 * 4

      let event = EventEntity()
      event.id = eventIndex
      event.startDate = eventTime
      event.endDate = eventTime.addingTimeInterval(eventDuration)
      event.title += " \(numberOfDemoEvents - eventIndex)"

      realmWrite {
        mainRealm.add(event, update: true)
      }
    }

    tableView.reloadData()
  }

  func showEvent(at indexPath: IndexPath) {
    navigationController?.pushViewController(ViewControllersFactory.eventPreviewViewController, animated: true)
  }
}
