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
  var date: Date
}

class PastEventsViewController: UIViewController {
  @IBOutlet fileprivate weak var tableView: UITableView! {
    didSet {
      tableView.register(PastEventsTableViewCell.nib, forCellReuseIdentifier: PastEventsTableViewCell.identifier)
      tableView.estimatedRowHeight = 100
      tableView.rowHeight = UITableViewAutomaticDimension
    }
  }
  //FIXME: Replace with real data source
  fileprivate var groupedEvents = [EventModel]()
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
    // swiftlint:disable:next force_cast
    let cell = tableView.dequeueReusableCell(withIdentifier: PastEventsTableViewCell.identifier, for: indexPath) as! PastEventsTableViewCell
    //FIXME: Replace with reald data source
    let event = groupedEvents[indexPath.section]
    cell.configure(with: event)
    return cell
  }
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    let date = groupedEvents[section].date
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
    for i in 0...10 {
      //Create event
      let eventTime = Date().addingTimeInterval(-TimeInterval(3600 * 24 * i))
      let event = EventModel(title: "Name of event - \(i)", date: eventTime)
      groupedEvents.append(event)
    }
    tableView.reloadData()
  }
  func showEvent(at indexPath: IndexPath) {
    navigationController?.pushViewController(ViewControllersFactory.eventPreviewViewController, animated: true)
  }
}
