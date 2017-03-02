//
//  PastEventsViewController.swift
//  CHMeetupApp
//
//  Created by Alexander Zimin on 22/02/2017.
//  Copyright © 2017 CocoaHeads Comunity. All rights reserved.
//

import UIKit

struct EventModel {
  var title: String
  var dateTitle: String
}

class PastEventsViewController: UIViewController {
  @IBOutlet fileprivate var tableView: UITableView! {
    didSet {
      tableView.register(PastEventsTableViewCell.nib, forCellReuseIdentifier: PastEventsTableViewCell.identifier)
      tableView.estimatedRowHeight = 100
      tableView.rowHeight = UITableViewAutomaticDimension
    }
  }
  //FIXME: Replace with real data source
  fileprivate var groupedEvents = [Date: [EventModel]]()
  // swiftlint:disable:next trailing_whitespace

  override func viewDidLoad() {
    super.viewDidLoad()
    fetchEvents()
  }
}

extension PastEventsViewController: UITableViewDataSource, UITableViewDelegate {

  func numberOfSections(in tableView: UITableView) -> Int {
    return groupedEvents.count
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //FIXME: Replace with reald data source
    return 1
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    // swiftlint:disable line_length
    // swiftlint:disable:next force_cast
    let cell = tableView.dequeueReusableCell(withIdentifier: PastEventsTableViewCell.identifier, for: indexPath) as! PastEventsTableViewCell

    //FIXME: Replace with real data source
    let events = groupedEvents[key(for: indexPath.section)]
    if let event = events?[indexPath.row] {
      cell.configure(with: event)
    }

    return cell
  }

  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    let date = key(for: section)

    return DateFormatter.localizedString(from: date, dateStyle: .short, timeStyle: .none)
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
    for eventIndex in 0...numberOfDemoEvents {
      //Create past event
      let oneDayTimeInterval = 3600 * 24
      let eventTime = Date().addingTimeInterval(-TimeInterval(oneDayTimeInterval * eventIndex))
      let timeTitle = DateFormatter.localizedString(from: eventTime, dateStyle: .medium, timeStyle: .short)
      let event = EventModel(title: "Name of event - \(numberOfDemoEvents - eventIndex)", dateTitle: timeTitle)
      groupedEvents[eventTime] = [event]
    }
    tableView.reloadData()
  }

  func key(for section: Int) -> Date {
    return groupedEvents.keys.sorted(by: { (prevDate, nextDate) -> Bool in
      return prevDate > nextDate
    })[section]
  }

  func showEvent(at indexPath: IndexPath) {
    navigationController?.pushViewController(ViewControllersFactory.eventPreviewViewController, animated: true)
  }
}
