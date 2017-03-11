//
//  EventPreviewViewController.swift
//  CHMeetupApp
//
//  Created by Alexander Zimin on 23/02/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

class EventPreviewViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    title = "Event Preview".localized
  }

  @IBAction func addToReminder(sender: UIButton) {
    Importer.import(event: EventEntity(), to: .reminder) { result in
      switch result {
      case .success:
        print("Added")
      case .permissionError:
        print("Show settings alert")
      case .saveError(let error):
        print("Error alert: \(error)")
      }
    }
  }

  @IBAction func addToCalendar(sender: UIButton) {
    Importer.import(event: EventEntity(), to: .calendar) { result in
      switch result {
      case .success:
        print("Added")
      case .permissionError:
        print("Show settings alert")
      case .saveError(let error):
        print("Error alert: \(error)")
      }
    }
  }

}
